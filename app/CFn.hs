{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}
module CFn
    ( PrimitiveType(..)
    , UpdateType(..)
    , PropertyType(..)
    , Property(..)
    , PropertyTypeDefinition(..)
    , AttributeType(..)
    , ResourceTypeDefinition(..)
    , Specification(..)
    ) where

import Data.Aeson ((.:), (.=))
import qualified Data.Aeson as DA (FromJSON, ToJSON, Value(..), object,
                                   parseJSON, toJSON, withObject)
import qualified Data.Aeson.TH as DA (Options(..), SumEncoding(..),
                                      defaultOptions, deriveJSON)
import qualified Data.HashMap.Strict as HM
import Data.Text (Text)

data PrimitiveType =
    CFnBoolean |
    CFnDouble |
    CFnInteger |
    CFnJson |
    CFnLong |
    CFnString |
    CFnTimestamp
    deriving (Show, Eq)
$(DA.deriveJSON DA.defaultOptions { DA.constructorTagModifier = drop 3, DA.sumEncoding = DA.UntaggedValue } ''PrimitiveType)

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
    { propertyName         :: !Text
    , propertyType         :: !PropertyType
    , propertyDocumentaion :: !Text
    , propertyRequired     :: !Bool
    , propertyUpdateType   :: !UpdateType
    } deriving (Show, Eq)

newtype Properties = Properties [Property]
    deriving (Show, Eq)

data PropertyTypeDefinition = PropertyTypeDefinition
    { propertyTypeDefinitionName          :: !Text
    , propertyTypeDefinitionDocumentation :: !Text
    , propertyTypeDefinitionProperties    :: !Properties
    } deriving (Show, Eq)
$(DA.deriveJSON DA.defaultOptions { DA.constructorTagModifier = drop 22, DA.sumEncoding = DA.UntaggedValue } ''PropertyTypeDefinition)

newtype PropertyTypeDefinitions = PropertyTypeDefinitions [PropertyTypeDefinition]
    deriving (Show, Eq)

data AttributeType =
    AttributeTypePrimitive !PrimitiveType |
    AttributeTypePrimitiveList !PrimitiveType
    deriving (Show, Eq)

data Attribute = Attribute
    { attributeName :: !Text
    , attributeType :: !AttributeType
    } deriving (Show, Eq)

newtype Attributes = Attributes [Attribute]
    deriving (Show, Eq)

data ResourceTypeDefinition = ResourceTypeDefinition
    { resourceTypeDefinitionName          :: !Text
    , resourceTypeDefinitionDocumentation :: !Text
    , resourceTypeDefinitionAttributes    :: ![Attribute]
    , resourceTypeDefinitionProperties    :: !Properties
    } deriving (Show, Eq)
$(DA.deriveJSON DA.defaultOptions { DA.constructorTagModifier = drop 22, DA.sumEncoding = DA.UntaggedValue } ''ResourceTypeDefinition)

newtype ResourceTypeDefinitions = ResourceTypeDefinitions [ResourceTypeDefinition]
    deriving (Show, Eq)

data Specification = Specification
    { specificationPropertyTypes                :: !PropertyTypeDefinitions
    , specificationResourceTypes                :: !ResourceTypeDefinitions
    , specificationResourceSpecificationVersion :: !Text
    } deriving (Show, Eq)
$(DA.deriveJSON DA.defaultOptions { DA.constructorTagModifier = drop 13, DA.sumEncoding = DA.UntaggedValue } ''Specification)

instance DA.FromJSON Properties where
    parseJSON = DA.withObject "Properties" $ fmap Properties . HM.foldrWithKey f (return [])

        where
        f n v a = (:) <$> DA.withObject "Property" (parse n) v <*> a

        parse n v =
            let t = HM.lookup "Type" v
                item = HM.lookup "ItemType" v
                pitem = HM.lookup "PrimitiveItemType" v

            in case (t, item, pitem) of
                (Just (DA.String "List"), Just (DA.String a), _) -> parseResourceList n v a
                (Just (DA.String "List"), Nothing, Just a @ DA.String {}) -> parsePrimitiveList n v =<< DA.parseJSON a
                (Just (DA.String t), _, _) -> parseResource n v t
                (Nothing, _, _) -> parsePrimitive n v =<< v .: "PrimitiveType"

        parseResource n v a = Property n (PropertyType a)
            <$> v .: "Documentation"
            <*> v .: "Required"
            <*> v .: "UpdateType"

        parsePrimitive n v a = Property n (PropertyTypePrimitive a)
            <$> v .: "Documentation"
            <*> v .: "Required"
            <*> v .: "UpdateType"

        parseResourceList n v a = Property n (PropertyTypeList a)
            <$> v .: "Documentation"
            <*> v .: "Required"
            <*> v .: "UpdateType"

        parsePrimitiveList n v a = Property n (PropertyTypePrimitiveList a)
            <$> v .: "Documentation"
            <*> v .: "Required"
            <*> v .: "UpdateType"

instance DA.ToJSON Properties where
    toJSON (Properties ps) = DA.Object . HM.fromList $ map f ps

        where

        f p = (propertyName p, toJSON' p)

        toJSON' (Property _ (PropertyType a) doc required update) =
            DA.object
            [ "Type" .= a
            , "Documentation" .= doc
            , "Required" .= required
            , "UpdateType" .= update
            ]

        toJSON' (Property _ (PropertyTypePrimitive a) doc required update) =
            DA.object
            [ "PrimitiveType" .= a
            , "Documentation" .= doc
            , "Required" .= required
            , "UpdateType" .= update
            ]

        toJSON' (Property _ (PropertyTypeList a) doc required update) =
            DA.object
            [ "Type" .= DA.String "List"
            , "ItemType" .= a
            , "Documentation" .= doc
            , "Required" .= required
            , "UpdateType" .= update
            ]

        toJSON' (Property _ (PropertyTypePrimitiveList a) doc required update) =
            DA.object
            [ "Type" .= DA.String "List"
            , "PrimitiveItemType" .= a
            , "Documentation" .= doc
            , "Required" .= required
            , "UpdateType" .= update
            ]

instance DA.FromJSON Attributes where
    parseJSON = DA.withObject "Attributes" $ fmap Attributes . HM.foldrWithKey f (return [])

        where

        f n v a = (:) <$> DA.withObject "Attribute" (parse n) v <*> a

        parse n v =
            let pitem = HM.lookup "PrimitiveItemType" v
            in case pitem of
                Just a  -> Attribute n . AttributeTypePrimitiveList <$> DA.parseJSON a
                Nothing -> Attribute n . AttributeTypePrimitive <$> v .: "PrimitiveType"

instance DA.ToJSON Attributes where
    toJSON (Attributes xs) = DA.Object . HM.fromList $ map f xs

        where
        f a = (attributeName a, toJSON' a)

        toJSON' (Attribute _ (AttributeTypePrimitive a)) =
            DA.object
            [ "PrimitiveType" .= a
            ]

        toJSON' (Attribute _ (AttributeTypePrimitiveList a)) =
            DA.object
            [ "Type" .= DA.String "List"
            , "PrimitiveItemType" .= a
            ]
