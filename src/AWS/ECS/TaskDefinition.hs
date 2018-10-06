{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.ECS.TaskDefinition
    ( ContainerDefinition(..)
    , MountPoint(..)
    , LogConfiguration(..)
    , Tmpfs(..)
    , TaskDefinitionPlacementConstraint(..)
    , LinuxParameters(..)
    , VolumeFrom(..)
    , KeyValuePair(..)
    , PortMapping(..)
    , Device(..)
    , Volume(..)
    , RepositoryCredentials(..)
    , HealthCheck(..)
    , HostVolumeProperties(..)
    , DockerVolumeConfiguration(..)
    , HostEntry(..)
    , KernelCapabilities(..)
    , Ulimit(..)
    , TaskDefinition(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data ContainerDefinition = ContainerDefinition
    { _ContainerDefinitionCommand :: Maybe [Text]
    , _ContainerDefinitionHostname :: Maybe Text
    , _ContainerDefinitionImage :: Maybe Text
    , _ContainerDefinitionRepositoryCredentials :: Maybe RepositoryCredentials
    , _ContainerDefinitionDockerSecurityOptions :: Maybe [Text]
    , _ContainerDefinitionHealthCheck :: Maybe HealthCheck
    , _ContainerDefinitionDisableNetworking :: Maybe Bool
    , _ContainerDefinitionVolumesFrom :: Maybe [VolumeFrom]
    , _ContainerDefinitionEnvironment :: Maybe [KeyValuePair]
    , _ContainerDefinitionEntryPoint :: Maybe [Text]
    , _ContainerDefinitionWorkingDirectory :: Maybe Text
    , _ContainerDefinitionPrivileged :: Maybe Bool
    , _ContainerDefinitionUlimits :: Maybe [Ulimit]
    , _ContainerDefinitionPortMappings :: Maybe [PortMapping]
    , _ContainerDefinitionMemory :: Maybe Int
    , _ContainerDefinitionExtraHosts :: Maybe [HostEntry]
    , _ContainerDefinitionDockerLabels :: Maybe Map
    , _ContainerDefinitionUser :: Maybe Text
    , _ContainerDefinitionLinuxParameters :: Maybe LinuxParameters
    , _ContainerDefinitionLogConfiguration :: Maybe LogConfiguration
    , _ContainerDefinitionDnsSearchDomains :: Maybe [Text]
    , _ContainerDefinitionDnsServers :: Maybe [Text]
    , _ContainerDefinitionName :: Maybe Text
    , _ContainerDefinitionMountPoints :: Maybe [MountPoint]
    , _ContainerDefinitionReadonlyRootFilesystem :: Maybe Bool
    , _ContainerDefinitionLinks :: Maybe [Text]
    , _ContainerDefinitionCpu :: Maybe Int
    , _ContainerDefinitionEssential :: Maybe Bool
    , _ContainerDefinitionMemoryReservation :: Maybe Int
    } deriving (Show, Eq)

data MountPoint = MountPoint
    { _MountPointContainerPath :: Maybe Text
    , _MountPointSourceVolume :: Maybe Text
    , _MountPointReadOnly :: Maybe Bool
    } deriving (Show, Eq)

data LogConfiguration = LogConfiguration
    { _LogConfigurationLogDriver :: Text
    , _LogConfigurationOptions :: Maybe Map
    } deriving (Show, Eq)

data Tmpfs = Tmpfs
    { _TmpfsSize :: Maybe Int
    , _TmpfsContainerPath :: Maybe Text
    , _TmpfsMountOptions :: Maybe [Text]
    } deriving (Show, Eq)

data TaskDefinitionPlacementConstraint = TaskDefinitionPlacementConstraint
    { _TaskDefinitionPlacementConstraintExpression :: Maybe Text
    , _TaskDefinitionPlacementConstraintType :: Text
    } deriving (Show, Eq)

data LinuxParameters = LinuxParameters
    { _LinuxParametersSharedMemorySize :: Maybe Int
    , _LinuxParametersTmpfs :: Maybe [Tmpfs]
    , _LinuxParametersInitProcessEnabled :: Maybe Bool
    , _LinuxParametersDevices :: Maybe [Device]
    , _LinuxParametersCapabilities :: Maybe KernelCapabilities
    } deriving (Show, Eq)

data VolumeFrom = VolumeFrom
    { _VolumeFromSourceContainer :: Maybe Text
    , _VolumeFromReadOnly :: Maybe Bool
    } deriving (Show, Eq)

data KeyValuePair = KeyValuePair
    { _KeyValuePairValue :: Maybe Text
    , _KeyValuePairName :: Maybe Text
    } deriving (Show, Eq)

data PortMapping = PortMapping
    { _PortMappingProtocol :: Maybe Text
    , _PortMappingHostPort :: Maybe Int
    , _PortMappingContainerPort :: Maybe Int
    } deriving (Show, Eq)

data Device = Device
    { _DeviceContainerPath :: Maybe Text
    , _DeviceHostPath :: Text
    , _DevicePermissions :: Maybe [Text]
    } deriving (Show, Eq)

data Volume = Volume
    { _VolumeDockerVolumeConfiguration :: Maybe DockerVolumeConfiguration
    , _VolumeName :: Maybe Text
    , _VolumeHost :: Maybe HostVolumeProperties
    } deriving (Show, Eq)

data RepositoryCredentials = RepositoryCredentials
    { _RepositoryCredentialsCredentialsParameter :: Maybe Text
    } deriving (Show, Eq)

data HealthCheck = HealthCheck
    { _HealthCheckCommand :: [Text]
    , _HealthCheckStartPeriod :: Maybe Int
    , _HealthCheckRetries :: Maybe Int
    , _HealthCheckInterval :: Maybe Int
    , _HealthCheckTimeout :: Maybe Int
    } deriving (Show, Eq)

data HostVolumeProperties = HostVolumeProperties
    { _HostVolumePropertiesSourcePath :: Maybe Text
    } deriving (Show, Eq)

data DockerVolumeConfiguration = DockerVolumeConfiguration
    { _DockerVolumeConfigurationDriver :: Maybe Text
    , _DockerVolumeConfigurationDriverOpts :: Maybe Map
    , _DockerVolumeConfigurationScope :: Maybe Text
    , _DockerVolumeConfigurationLabels :: Maybe Map
    , _DockerVolumeConfigurationAutoprovision :: Maybe Bool
    } deriving (Show, Eq)

data HostEntry = HostEntry
    { _HostEntryHostname :: Text
    , _HostEntryIpAddress :: Text
    } deriving (Show, Eq)

data KernelCapabilities = KernelCapabilities
    { _KernelCapabilitiesDrop :: Maybe [Text]
    , _KernelCapabilitiesAdd :: Maybe [Text]
    } deriving (Show, Eq)

data Ulimit = Ulimit
    { _UlimitName :: Text
    , _UlimitHardLimit :: Int
    , _UlimitSoftLimit :: Int
    } deriving (Show, Eq)

data TaskDefinition = TaskDefinition
    { _TaskDefinitionExecutionRoleArn :: Maybe Text
    , _TaskDefinitionFamily :: Maybe Text
    , _TaskDefinitionRequiresCompatibilities :: Maybe [Text]
    , _TaskDefinitionContainerDefinitions :: Maybe [ContainerDefinition]
    , _TaskDefinitionMemory :: Maybe Text
    , _TaskDefinitionTaskRoleArn :: Maybe Text
    , _TaskDefinitionPlacementConstraints :: Maybe [TaskDefinitionPlacementConstraint]
    , _TaskDefinitionNetworkMode :: Maybe Text
    , _TaskDefinitionVolumes :: Maybe [Volume]
    , _TaskDefinitionCpu :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 20 } ''ContainerDefinition)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''MountPoint)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''LogConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 6 } ''Tmpfs)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 34 } ''TaskDefinitionPlacementConstraint)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 16 } ''LinuxParameters)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 11 } ''VolumeFrom)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 13 } ''KeyValuePair)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''PortMapping)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Device)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Volume)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 22 } ''RepositoryCredentials)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''HealthCheck)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 21 } ''HostVolumeProperties)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 26 } ''DockerVolumeConfiguration)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''HostEntry)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 19 } ''KernelCapabilities)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 7 } ''Ulimit)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 15 } ''TaskDefinition)

resourceJSON :: TaskDefinition -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::ECS::TaskDefinition" :: Text), "Properties" .= a ]
