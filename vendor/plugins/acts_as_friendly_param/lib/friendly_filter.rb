require 'record_moved'

module ActionController
  # three_oh_one is a filter for your controller that catches RecordMoved
  # errors raised during an ActiveRecord#find method on acts_as_friendly_param
  # enabled models
  #
  # it will also remove trailing slashes from URLs and redirect them
  #
  #
  # add an around_filter to catch RecordMoved
  #
  class FriendlyFilter
    
    def filter(controller)
      # set controller
      @controller = controller
      # run filter
      if request.get? && !simplest_url?
        # ensure url is same as those constructed by routes
        # and any remove trailing slashes on the request
        redirect_to simplest_url
      else
        # catch and redirect RecordMoved errors
        begin
          yield
        rescue ActiveRecord::RecordMoved => ex
          if request.get?
            redirect_to record_moved_url(ex.record) 
          else
            raise
          end
        end
      end
    end
    
    # get request from controller
    #
    def request
      @controller.request
    end
    
    # get url functions from controller
    #
    def url_for(*args)
      @controller.url_for(*args)
    end
    
    # get params from controller
    #
    def params
      @controller.params
    end
    
    # simplest_url replaces a perfectly legal url with the equivilent
    # url built from routes... this can be useful if you change
    # your routes file and want an existing application to heal
    # itself.
    # but also takes care of removing trailing slashes
    # 
    # adapted from Dan Kubb's comment
    #
    # http://www.example.com/books?format=htm
    #
    # might turn into
    #
    # http://www.example.com/books.html
    #
    def simplest_url?
      request.protocol + request.host_with_port + request.request_uri == simplest_url
    end
    
    def simplest_url
      url_for(:overwrite_params =>{})
    end
    
    # generate the correct url for
    #
    def record_moved_url(record)
      #
      # try and handle nested resources by checking if the param is available
      # that correctly identifies the nested item.
      #
      # side effect: when using #to_param and .find('8-blah') 
      #
      overwrite_param = if params[record.class.to_s.foreign_key]
        record.class.to_s.foreign_key
      elsif params[record.class.primary_key]
        record.class.primary_key
      else
        # could not find a URL to fix...
        # try to give a useful help message so that the URL can be fixed
        # gather posible suspects for bad params
        bad_param_suspects = params.reject{|k,v| !(v =~ /#{record.id}/)}.map{|k,v| [k,v]}
        tip = case bad_param_suspects.size
        when 0
          ''
        when 1
          %{TIP:
            Try using params[:#{bad_param_suspects.first[0]}].to_i 
            OR name the parameter :#{record.class.to_s.foreign_key} instead of :#{bad_param_suspects.first[0]} and let the plugin redirect.
          }
        else
          %{TIP:            
            Take a look at how you are using the following params, maybe call #to_i
            on the one you used to try and find the #{record.class.name}
            #{bad_param_suspects.map{|pair| ":#{pair[0]}"}.join(',')}.
          }
        end
        raise ::ActiveRecord::RecordNotFound, %{
          This RecordNotFound error is most likely rasied becuase you declared acts_as_friendly_param for #{record.class.name.downcase.pluralize} 
          and then tried to use #{record.class.name}.find('#{record.id}') instead of #{record.class.name}.find(#{record.id})

          #{tip}
          To disable strict checking of record id's in URLs please use
          
          acts_as_friendly_param :name, :strict => false
        }.squeeze(' ')
      end
      url_for(overwrite_param => record)
    end
    
    # same as redirect_to but uses 301 instead of 302
    #
    def redirect_to(url_opts)
      @controller.send :erase_results
      @controller.send :redirect_to, url_opts
      @controller.headers["Status"] = @controller.send(:interpret_status, 301)
    end

  end
end
