{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module AWS.SSM.PatchBaseline
    ( PatchFilterGroup(..)
    , RuleGroup(..)
    , PatchFilter(..)
    , Rule(..)
    , PatchSource(..)
    , PatchBaseline(..)
    , resourceJSON
    ) where

import AWS (Map, Tag)
import Data.Text (Text)
import Data.Aeson ((.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), Options(..), Value, defaultOptions, object)
import qualified Data.Aeson.TH as DA (deriveJSON)

data PatchFilterGroup = PatchFilterGroup
    { _PatchFilterGroupPatchFilters :: Maybe [PatchFilter]
    } deriving (Show, Eq)

data RuleGroup = RuleGroup
    { _RuleGroupPatchRules :: Maybe [Rule]
    } deriving (Show, Eq)

data PatchFilter = PatchFilter
    { _PatchFilterValues :: Maybe [Text]
    , _PatchFilterKey :: Maybe Text
    } deriving (Show, Eq)

data Rule = Rule
    { _RuleApproveAfterDays :: Maybe Int
    , _RulePatchFilterGroup :: Maybe PatchFilterGroup
    , _RuleEnableNonSecurity :: Maybe Bool
    , _RuleComplianceLevel :: Maybe Text
    } deriving (Show, Eq)

data PatchSource = PatchSource
    { _PatchSourceName :: Maybe Text
    , _PatchSourceConfiguration :: Maybe Text
    , _PatchSourceProducts :: Maybe [Text]
    } deriving (Show, Eq)

data PatchBaseline = PatchBaseline
    { _PatchBaselineApprovalRules :: Maybe RuleGroup
    , _PatchBaselineOperatingSystem :: Maybe Text
    , _PatchBaselineGlobalFilters :: Maybe PatchFilterGroup
    , _PatchBaselineApprovedPatchesComplianceLevel :: Maybe Text
    , _PatchBaselineApprovedPatches :: Maybe [Text]
    , _PatchBaselineApprovedPatchesEnableNonSecurity :: Maybe Bool
    , _PatchBaselineRejectedPatches :: Maybe [Text]
    , _PatchBaselineSources :: Maybe [PatchSource]
    , _PatchBaselineName :: Text
    , _PatchBaselinePatchGroups :: Maybe [Text]
    , _PatchBaselineDescription :: Maybe Text
    } deriving (Show, Eq)

$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 17 } ''PatchFilterGroup)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 10 } ''RuleGroup)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''PatchFilter)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 5 } ''Rule)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 12 } ''PatchSource)
$(DA.deriveJSON DA.defaultOptions { DA.fieldLabelModifier = drop 14 } ''PatchBaseline)

resourceJSON :: PatchBaseline -> DA.Value
resourceJSON a = DA.object [ "Type" .= ("AWS::SSM::PatchBaseline" :: Text), "Properties" .= a ]
