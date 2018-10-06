{-# LANGUAGE OverloadedStrings #-}
module AWS
    ( Tag(..)
    , Map
    ) where

import Data.Aeson ((.:), (.=))
import qualified Data.Aeson as DA (FromJSON(..), ToJSON(..), object, withObject)
import Data.HashMap.Strict (HashMap)
import Data.Text (Text)

type Map = HashMap Text Text

newtype Tag = Tag (Text, Text)
    deriving (Show, Eq)

instance DA.FromJSON Tag where
    parseJSON = DA.withObject "Tag" $ \a -> do
        k <- a .: "Key"
        v <- a .: "Value"
        return (Tag (k, v))

instance DA.ToJSON Tag where
    toJSON (Tag (k, v)) =
        DA.object [ "Key" .= k, "Value" .= v ]
