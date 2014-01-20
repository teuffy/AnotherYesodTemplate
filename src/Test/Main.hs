module Test.Main where

import           Test.Import
import           Test.Home

main :: IO ()
main = do
    app <- startApp
    hspec $ yesodSpec app
            -- put Specs here..
            homeSpecs
