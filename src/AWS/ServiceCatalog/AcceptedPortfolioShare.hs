{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ServiceCatalog.AcceptedPortfolioShare
    ( AcceptedPortfolioShare(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data AcceptedPortfolioShare = AcceptedPortfolioShare
    { _AcceptedPortfolioSharePortfolioId :: Text
    , _AcceptedPortfolioShareAcceptLanguage :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 23 } ''AcceptedPortfolioShare)

resourceJSON :: AcceptedPortfolioShare -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ServiceCatalog::AcceptedPortfolioShare" :: Text), "Properties" .= a ]
