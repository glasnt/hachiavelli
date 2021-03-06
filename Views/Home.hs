{-# LANGUAGE
   OverloadedStrings
 , GeneralizedNewtypeDeriving 
  #-}
module Views.Home (homeView,layout) where

import           Data.Monoid                 (mempty)
import           Data.Text.Lazy              (toStrict)
import           Prelude                     hiding (div, head, id)
import           Text.Blaze.Internal         (string)
import           Text.Blaze.Html             (Html, toHtml)
import           Text.Blaze.Html5            (Html, a, body, button,
                                              dataAttribute, div, docTypeHtml,
                                              form, h1, h2, head, input, li,
                                              link, meta, p, script, style,
                                              title, ul, (!))
import           Text.Blaze.Html5.Attributes (charset, class_, content, href,
                                              httpEquiv, id, media, name,
                                              placeholder, rel, src, type_)
import           Views.Utils
import           Web.Scotty                  (ActionM, Parsable)


newtype Metric = Metric { metric_id :: String }
    deriving (Parsable, Show)

layout :: Html -> Html -> Html
layout t b = docTypeHtml $ do
           pet "<!--[if lt IE 7]>      <html class='no-js lt-ie9 lt-ie8 lt-ie7'> <![endif]-->"
           pet "<!--[if IE 7]>         <html class='no-js lt-ie9 lt-ie8'/> <![endif]-->"
           pet "<!--[if IE 8]>         <html class='no-js lt-ie9'> <![endif]-->"
           pet "<!--[if gt IE 8]><!--> <html class='no-js'> <!--<![endif]-->"
           head $ do
             title t
             meta ! charset "utf-8"
             meta ! httpEquiv "X-UA-Compatible" ! content "IE=edge,chrome=1"
             meta ! name "description" ! content "Inspire Text"
             meta ! name "viewport" ! content "width=device-width"
             script ! src "//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" $ mempty
             script ! src "//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js" $ mempty
             link ! href "//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" ! rel  "stylesheet" ! media "screen"
           body $ do
             navBar >> b

metricTitle :: String
metricTitle = "SineWave"

gon :: String -> String
gon m  = "\n//<![CDATA[\nwindow.gon={}; gon.metric={};\
            \gon.message='Hachiavelli is awesome.'; \
            \gon.metric.title='"++metricTitle++"'; \
            \gon.metric.id='"++m++"'; \n\
            \//]]>"

include_gon m = script $ (string (gon $ metric_id(m)))

homeView :: Metric -> ActionM()
homeView m = blaze $ layout "home" $ do
             include_gon m 
             div ! class_ "container" $ do
               h1 "Hachiavelli"
               div ! id "message" $ mempty
               div ! class_ "col-md-12" $ do
                 script ! src "javascript/d3.v3.js" $ mempty
                 script ! src "javascript/cubism.v1.js" $ mempty
                 link ! href "stylesheets/cubism.css" ! rel "stylesheet"
                 link ! href "stylesheets/horizon.css" ! rel "stylesheet"
                 div ! id "horizon_graph" $ mempty
                 script ! src "javascript/graph.js" $ mempty
               script $ "jQuery('#message')[0].innerHTML = gon.message"


navBar :: Html
navBar = div ! class_ "navbar navbar-default navbar-static-top" $ div ! class_ "container" $ do
           div ! class_ "navbar-header" $ do
             button ! type_ "button"
                    ! class_ "navbar-toggle" ! dataAttribute "toggle" "collapse" ! dataAttribute "target" ".navbar-collapse" $ do
               a ! class_ "navbar-brand" ! href "#" $ "λ"
           div ! class_ "navbar-collapse collapse" $ ul ! class_ "nav navbar-nav" $ do
             li ! class_ "active" $ a ! href "#" $ "Test the Graph"




