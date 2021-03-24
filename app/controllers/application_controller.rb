class ApplicationController < ActionController::Base
    def hello
        render html: "Hello world o"
        #render means to display or show something
    end
end
