    FROM elixir:1.12
    
    # Argument handling
    ARG MIX_ENV

   
    
    # Key management by environment
    ENV MIX_ENV ${MIX_ENV}
   

    RUN apt-get update && \
    apt-get install -y inotify-tools && \
    mix local.hex --force && \
    mix archive.install hex phx_new 1.5.3 --force && \
    mix local.rebar --force

    ENV APP_HOME /app
    RUN mkdir $APP_HOME
    WORKDIR $APP_HOME

    COPY . .

     RUN for keyval in $(grep -E '": [^\{]' secrets.json | sed -e 's/: /=/' -e "s/\(\,\)$//"); do eval export $keyval; done && \
        echo $TOKEN_WP_RC && \
        echo $URL_WP && \
        mix deps.get && \
        mix release

 RUN mix phx.swagger.generate

    RUN echo "America/Fortaleza" > /etc/timezone
 ENTRYPOINT ["/bin/sh", "-c" , "mix deps.get && mix phx.server"] 
   