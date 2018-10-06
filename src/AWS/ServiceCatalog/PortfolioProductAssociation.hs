{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ServiceCatalog.PortfolioProductAssociation
    ( PortfolioProductAssociation(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data PortfolioProductAssociation = PortfolioProductAssociation
    { _PortfolioProductAssociationPortfolioId :: Text
    , _PortfolioProductAssociationSourcePortfolioId :: Maybe Text
    , _PortfolioProductAssociationAcceptLanguage :: Maybe Text
    , _PortfolioProductAssociationProductId :: Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 28 } ''PortfolioProductAssociation)

resourceJSON :: PortfolioProductAssociation -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ServiceCatalog::PortfolioProductAssociation" :: Text), "Properties" .= a ]
