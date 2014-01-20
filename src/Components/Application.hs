module Components.Application where

import Database.Persist.Sqlite
import Yesod.Static
import Network.HTTP.Conduit (Manager)

data App = App 
    { connPool :: ConnectionPool
    , getStatic :: Static
    , httpManager :: Manager
    }
