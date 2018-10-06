{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.CloudFront.StreamingDistribution
    ( TrustedSigners(..)
    , Logging(..)
    , S3Origin(..)
    , StreamingDistributionConfig(..)
    , StreamingDistribution(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data TrustedSigners = TrustedSigners
    { _TrustedSignersAwsAccountNumbers :: Maybe [Text]
    , _TrustedSignersEnabled :: Bool
    } deriving (Show, Eq)

data Logging = Logging
    { _LoggingEnabled :: Bool
    , _LoggingPrefix :: Text
    , _LoggingBucket :: Text
    } deriving (Show, Eq)

data S3Origin = S3Origin
    { _S3OriginDomainName :: Text
    , _S3OriginOriginAccessIdentity :: Text
    } deriving (Show, Eq)

data StreamingDistributionConfig = StreamingDistributionConfig
    { _StreamingDistributionConfigEnabled :: Bool
    , _StreamingDistributionConfigAliases :: Maybe [Text]
    , _StreamingDistributionConfigPriceClass :: Maybe Text
    , _StreamingDistributionConfigS3Origin :: S3Origin
    , _StreamingDistributionConfigTrustedSigners :: TrustedSigners
    , _StreamingDistributionConfigLogging :: Maybe Logging
    , _StreamingDistributionConfigComment :: Text
    } deriving (Show, Eq)

data StreamingDistribution = StreamingDistribution
    { _StreamingDistributionStreamingDistributionConfig :: StreamingDistributionConfig
    , _StreamingDistributionTags :: [Tag]
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''TrustedSigners)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Logging)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 9 } ''S3Origin)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 28 } ''StreamingDistributionConfig)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''StreamingDistribution)

resourceJSON :: StreamingDistribution -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::CloudFront::StreamingDistribution" :: Text), "Properties" .= a ]
