module Components.Routes where

import           Yesod
import           Yesod.Static
import           Components.Application
import           Yesod.Auth

{- Define Routes -}
mkYesodData "App" [parseRoutes|
/         HomeR     GET
/markdown MarkdownR PUT
/fib/#Int FibR      GET
/static StaticR Static getStatic
/auth AuthR Auth getAuth
|]

staticDir = "static"