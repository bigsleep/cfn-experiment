{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ServiceCatalog.PortfolioPrincipalAssociation
    ( PortfolioPrincipalAssociation(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data PortfolioPrincipalAssociation = PortfolioPrincipalAssociation
    { _PortfolioPrincipalAssociationPortfolioId :: Text
    , _PortfolioPrincipalAssociationPrincipalType :: Text
    , _PortfolioPrincipalAssociationPrincipalARN :: Text
    , _PortfolioPrincipalAssociationAcceptLanguage :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 30 } ''PortfolioPrincipalAssociation)

resourceJSON :: PortfolioPrincipalAssociation -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ServiceCatalog::PortfolioPrincipalAssociation" :: Text), "Properties" .= a ]
