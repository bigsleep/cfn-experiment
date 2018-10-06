{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.Batch.JobDefinition
    ( Ulimit(..)
    , Environment(..)
    , ContainerProperties(..)
    , Timeout(..)
    , Volumes(..)
    , MountPoints(..)
    , RetryStrategy(..)
    , VolumesHost(..)
    , JobDefinition(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data Ulimit = Ulimit
    { _UlimitName :: Text
    , _UlimitHardLimit :: Int
    , _UlimitSoftLimit :: Int
    } deriving (Show, Eq)

data Environment = Environment
    { _EnvironmentValue :: Maybe Text
    , _EnvironmentName :: Maybe Text
    } deriving (Show, Eq)

data ContainerProperties = ContainerProperties
    { _ContainerPropertiesCommand :: Maybe [Text]
    , _ContainerPropertiesImage :: Text
    , _ContainerPropertiesEnvironment :: Maybe [Environment]
    , _ContainerPropertiesPrivileged :: Maybe Bool
    , _ContainerPropertiesUlimits :: Maybe [Ulimit]
    , _ContainerPropertiesJobRoleArn :: Maybe Text
    , _ContainerPropertiesMemory :: Int
    , _ContainerPropertiesUser :: Maybe Text
    , _ContainerPropertiesMountPoints :: Maybe [MountPoints]
    , _ContainerPropertiesVolumes :: Maybe [Volumes]
    , _ContainerPropertiesReadonlyRootFilesystem :: Maybe Bool
    , _ContainerPropertiesVcpus :: Int
    } deriving (Show, Eq)

data Timeout = Timeout
    { _TimeoutAttemptDurationSeconds :: Maybe Int
    } deriving (Show, Eq)

data Volumes = Volumes
    { _VolumesName :: Maybe Text
    , _VolumesHost :: Maybe VolumesHost
    } deriving (Show, Eq)

data MountPoints = MountPoints
    { _MountPointsContainerPath :: Maybe Text
    , _MountPointsSourceVolume :: Maybe Text
    , _MountPointsReadOnly :: Maybe Bool
    } deriving (Show, Eq)

data RetryStrategy = RetryStrategy
    { _RetryStrategyAttempts :: Maybe Int
    } deriving (Show, Eq)

data VolumesHost = VolumesHost
    { _VolumesHostSourcePath :: Maybe Text
    } deriving (Show, Eq)

data JobDefinition = JobDefinition
    { _JobDefinitionJobDefinitionName :: Maybe Text
    , _JobDefinitionRetryStrategy :: Maybe RetryStrategy
    , _JobDefinitionParameters :: Maybe DA.Value
    , _JobDefinitionType :: Text
    , _JobDefinitionTimeout :: Maybe Timeout
    , _JobDefinitionContainerProperties :: ContainerProperties
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Ulimit)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''Environment)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''ContainerProperties)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Timeout)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 8 } ''Volumes)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''MountPoints)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''RetryStrategy)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''VolumesHost)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''JobDefinition)

resourceJSON :: JobDefinition -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::Batch::JobDefinition" :: Text), "Properties" .= a ]
