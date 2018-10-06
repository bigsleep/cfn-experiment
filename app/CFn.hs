{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}
module CFn
    ( PrimitiveType(..)
    , UpdateType(..)
    , PropertyType(..)
    , Property(..)
    , PropertyTypeDefinition(..)
    , PropertyTypeDefinitions(..)
    , AttributeType(..)
    , Attribute(..)
    , Attributes(..)
    , ResourceTypeDefinition(..)
    , Specification(..)
    ) where

import Data.Aeson ((.:), (.=))
import qualified Data.Aeson as DA (FromJSON, ToJSON, Value(..), object,
                                   parseJSON, toJSON, withObject)
import qualified Data.Aeson.TH as DA (Options(..), SumEncoding(..),
                                      defaultOptions, deriveJSON)
import Data.HashMap.Strict (HashMap)
import qualified Data.HashMap.Strict as HM
import Data.Text (Text)
import qualified Data.Text as Text

data PrimitiveType =
    PrimBoolean |
    PrimDouble |
    PrimInteger |
    PrimJson |
    PrimLong |
    PrimString |
    PrimTimestamp
    deriving (Show, Eq)
$(DA.deriveJSON DA.defaultOptions { DA.constructorTagModifier = drop 4, DA.sumEncoding = DA.UntaggedValue } ''PrimitiveType)

data UpdateType =
    UpdateTypeImmutable |
    UpdateTypeMutable |
    UpdateTypeConditional
    deriving (Show, Eq)
$(DA.deriveJSON DA.defaultOptions { DA.constructorTagModifier = drop 10, DA.sumEncoding = DA.UntaggedValue } ''UpdateType)

data PropertyType =
    PropertyType !Text |
    PropertyTypePrimitive !PrimitiveType |
    PropertyTypeList !Text |
    PropertyTypePrimitiveList !PrimitiveType
    deriving (Show, Eq)

data Property = Property
    { propertyType         :: !PropertyType
    , propertyDocumentaion :: !Text
    , propertyRequired     :: !Bool
    , propertyUpdateType   :: !UpdateType
    } deriving (Show, Eq)

data PropertyTypeDefinition = PropertyTypeDefinition
    { propertyTypeDefinitionNameSpace     :: !Text
    , propertyTypeDefinitionName          :: !Text
    , propertyTypeDefinitionDocumentation :: !Text
    , propertyTypeDefinitionProperties    :: !(HashMap Text Property)
    } deriving (Show, Eq)

newtype PropertyTypeDefinitions = PropertyTypeDefinitions
    { unPropertyTypeDefinitions :: HashMap Text [PropertyTypeDefinition] }
    deriving (Show, Eq)

data AttributeType =
    AttributeTypePrimitive !PrimitiveType |
    AttributeTypePrimitiveList !PrimitiveType
    deriving (Show, Eq)

newtype Attribute = Attribute
    { attributeType :: AttributeType
    } deriving (Show, Eq)

newtype Attributes = Attributes
    { unAttributes :: [Attribute] }
    deriving (Show, Eq)

data ResourceTypeDefinition = ResourceTypeDefinition
    { resourceTypeDefinitionDocumentation :: !Text
    , resourceTypeDefinitionAttributes    :: !(Maybe (HashMap Text Attribute))
    , resourceTypeDefinitionProperties    :: !(HashMap Text Property)
    } deriving (Show, Eq)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22, DA.sumEncoding = DA.UntaggedValue } ''ResourceTypeDefinition)

data Specification = Specification
    { specificationPropertyTypes                :: !PropertyTypeDefinitions
    , specificationResourceTypes                :: !(HashMap Text ResourceTypeDefinition)
    , specificationResourceSpecificationVersion :: !Text
    } deriving (Show, Eq)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13, DA.sumEncoding = DA.UntaggedValue } ''Specification)

instance DA.FromJSON Property where
    parseJSON = DA.withObject "Properties" $ \v ->
        let t = HM.lookup "Type" v
            item = HM.lookup "ItemType" v
            pitem = HM.lookup "PrimitiveItemType" v

        in case (t, item, pitem) of
            (Just (DA.String "List"), Just (DA.String a), _) -> parseResourceList v a
            (Just (DA.String "List"), Nothing, Just a @ DA.String {}) -> parsePrimitiveList v =<< DA.parseJSON a
            (Just (DA.String t), _, _) -> parseResource v t
            (Nothing, _, _) -> parsePrimitive v =<< v .: "PrimitiveType"

        where
        parseResource v a = Property (PropertyType a)
            <$> v .: "Documentation"
            <*> v .: "Required"
            <*> v .: "UpdateType"

        parsePrimitive v a = Property (PropertyTypePrimitive a)
            <$> v .: "Documentation"
            <*> v .: "Required"
            <*> v .: "UpdateType"

        parseResourceList v a = Property (PropertyTypeList a)
            <$> v .: "Documentation"
            <*> v .: "Required"
            <*> v .: "UpdateType"

        parsePrimitiveList v a = Property (PropertyTypePrimitiveList a)
            <$> v .: "Documentation"
            <*> v .: "Required"
            <*> v .: "UpdateType"

instance DA.ToJSON Property where
    toJSON (Property (PropertyType a) doc required update) =
        DA.object
        [ "Type" .= a
        , "Documentation" .= doc
        , "Required" .= required
        , "UpdateType" .= update
        ]

    toJSON (Property (PropertyTypePrimitive a) doc required update) =
        DA.object
        [ "PrimitiveType" .= a
        , "Documentation" .= doc
        , "Required" .= required
        , "UpdateType" .= update
        ]

    toJSON (Property (PropertyTypeList a) doc required update) =
        DA.object
        [ "Type" .= DA.String "List"
        , "ItemType" .= a
        , "Documentation" .= doc
        , "Required" .= required
        , "UpdateType" .= update
        ]

    toJSON (Property (PropertyTypePrimitiveList a) doc required update) =
        DA.object
        [ "Type" .= DA.String "List"
        , "PrimitiveItemType" .= a
        , "Documentation" .= doc
        , "Required" .= required
        , "UpdateType" .= update
        ]

instance DA.FromJSON Attribute where
    parseJSON = DA.withObject "Attributes" $ \v ->
        let pitem = HM.lookup "PrimitiveItemType" v
        in case pitem of
            Just a  -> Attribute . AttributeTypePrimitiveList <$> DA.parseJSON a
            Nothing -> Attribute . AttributeTypePrimitive <$> v .: "PrimitiveType"

instance DA.ToJSON Attribute where
    toJSON (Attribute (AttributeTypePrimitive a)) =
        DA.object
        [ "PrimitiveType" .= a
        ]

    toJSON (Attribute (AttributeTypePrimitiveList a)) =
        DA.object
        [ "Type" .= DA.String "List"
        , "PrimitiveItemType" .= a
        ]

instance DA.FromJSON PropertyTypeDefinitions where
    parseJSON = DA.withObject "PropertyTypeDefinitions" $ fmap PropertyTypeDefinitions . HM.foldrWithKey f (return HM.empty)

        where

        f k v m =
            let (ns, n') = Text.breakOn "." k
                n = Text.drop 1 n'
                a = return <$> DA.withObject "PropertyTypeDefinition" (parse ns n) v
            in HM.insertWith (++) ns <$> a <*> m

        parse ns n v = PropertyTypeDefinition ns n
            <$> v .: "Documentation"
            <*> v .: "Properties"

instance DA.ToJSON PropertyTypeDefinitions where
    toJSON (PropertyTypeDefinitions ds) = DA.object . map f . concat . HM.elems $ ds
        where
        f (PropertyTypeDefinition ns n doc ps) =
            let k = Text.concat [ns, ".", n]
                v = DA.object
                    [ "Documentations" .= doc
                    , "Properties" .= DA.toJSON ps
                    ]
            in (k, v)
