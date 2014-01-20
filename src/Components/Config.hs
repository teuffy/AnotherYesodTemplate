module Components.Config where

import Data.Text
import Components.Application
import Yesod
import Yesod.Auth
import Components.Routes

jasmineActivate :: Bool
jasmineActivate = True

author :: Text
author = "Kevin Jahns"

generalWebsiteDescription :: Text
generalWebsiteDescription = "Test site"

development :: Bool
development = True

production :: Bool
production = not development

navbar = Navbar [Simple HomeR "Home", Dropdown "Dropthis" [(HomeR,"That"),(HomeR,"This")]] [Simple (AuthR LoginR) "Login"]

data Navbar = Navbar { left :: [NavbarElement], right :: [NavbarElement] }
data NavbarElement = Simple (Route App) Text | Dropdown Text [(Route App, Text)]