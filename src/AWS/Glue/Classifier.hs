{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Glue.Classifier
    ( JsonClassifier(..)
    , GrokClassifier(..)
    , XMLClassifier(..)
    , Classifier(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data JsonClassifier = JsonClassifier
    { _JsonClassifierJsonPath :: Text
    , _JsonClassifierName :: Maybe Text
    } deriving (Show, Eq)

data GrokClassifier = GrokClassifier
    { _GrokClassifierClassification :: Text
    , _GrokClassifierName :: Maybe Text
    , _GrokClassifierCustomPatterns :: Maybe Text
    , _GrokClassifierGrokPattern :: Text
    } deriving (Show, Eq)

data XMLClassifier = XMLClassifier
    { _XMLClassifierClassification :: Text
    , _XMLClassifierName :: Maybe Text
    , _XMLClassifierRowTag :: Text
    } deriving (Show, Eq)

data Classifier = Classifier
    { _ClassifierGrokClassifier :: Maybe GrokClassifier
    , _ClassifierXMLClassifier :: Maybe XMLClassifier
    , _ClassifierJsonClassifier :: Maybe JsonClassifier
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''JsonClassifier)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''GrokClassifier)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''XMLClassifier)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''Classifier)

resourceJSON :: Classifier -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Glue::Classifier" :: Text), "Properties" .= a ]
