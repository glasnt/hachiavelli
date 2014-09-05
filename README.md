Machiavelli? Most like Hachiavelli

Template: https://github.com/scotty-web/scotty-starter

To Setup: 
 - installation of Machiavelli, `bundle exec rails server` -> serve on port 3000
 - append to `app/controller/application_controller.rb` to allow this app to access the rails JSON endpoints
```
 class ApplicationController < ActionController::Base
        protect_from_forgery
+       after_filter :set_access_control_headers
+
+       def set_access_control_headers 
+               headers['Access-Control-Allow-Origin'] = '*' 
+               headers['Access-Control-Request-Method'] = '*' 
+       end
 end
```

 - clone this repo, then `cabal build && PORT=4000 ./dist/build/app/app`

Then, going to `http://localhost:4000/?metric_id=blah` should show a purdy graph.

`blah` in this case should be a ORIGIN~Address that Machiavelli understands. 

![Demo Running](http://glasnt.beta.anchortrove.com/i/4495af.png)
