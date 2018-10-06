{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ServiceCatalog.PortfolioShare
    ( PortfolioShare(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data PortfolioShare = PortfolioShare
    { _PortfolioSharePortfolioId :: Text
    , _PortfolioShareAccountId :: Text
    , _PortfolioShareAcceptLanguage :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''PortfolioShare)

resourceJSON :: PortfolioShare -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ServiceCatalog::PortfolioShare" :: Text), "Properties" .= a ]
