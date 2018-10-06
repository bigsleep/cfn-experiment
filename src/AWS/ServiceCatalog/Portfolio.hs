{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ServiceCatalog.Portfolio
    ( Portfolio(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Portfolio = Portfolio
    { _PortfolioAcceptLanguage :: Maybe Text
    , _PortfolioDisplayName :: Text
    , _PortfolioDescription :: Maybe Text
    , _PortfolioProviderName :: Text
    , _PortfolioTags :: Maybe [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''Portfolio)

resourceJSON :: Portfolio -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ServiceCatalog::Portfolio" :: Text), "Properties" .= a ]
