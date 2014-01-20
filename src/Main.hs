module Main  where

import Handler.Fib
import Handler.Home
import Handler.Markdown
import Import
import Components.Auth
import Yesod.Auth

{- We imported the Handlers in this Module,
   now we define the routes -}
mkYesodDispatch "App" resourcesApp

main :: IO ()
main = do
    app <- startApp
    warpEnv app