{-# LANGUAGE OverloadedStrings #-}
module Main where

import AWS.IAM.User
import qualified Data.Aeson as DA
import qualified Data.ByteString as BS
import qualified Data.ByteString.Lazy as BS (toStrict)
import Test.Hspec

input :: BS.ByteString
input = "{\"Type\":\"AWS::IAM::User\",\"Properties\":{\"Groups\":[\"Admin\"],\"Path\":\"aaa\",\"LoginProfile\":{\"Password\":\"xxxx\",\"PasswordResetRequired\":true},\"UserName\":\"user1\",\"ManagedPolicyArns\":null,\"Policies\":null}}"

user1 :: User
user1 = User (Just ["Admin"]) (Just "aaa") (Just (LoginProfile "xxxx" (Just True))) (Just "user1") Nothing Nothing

main :: IO ()
main = hspec $ describe "resourceJSON" $ do
    it "resourceJSON" $ do
        let x = BS.toStrict . DA.encode $ resourceJSON user1
            expected = input
        x `shouldBe` expected
