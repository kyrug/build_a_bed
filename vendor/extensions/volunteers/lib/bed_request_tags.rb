module BedRequestTags
  include Radiant::Taggable

  tag 'bed_request' do |tag|
    tag.expand
  end

  desc %{
    Renders a bed request form

    *Usage:*
    <pre><code><r:bed_request:form>...</r:bed_request:form></code></pre>
  }
  tag 'bed_request:form' do |tag|
    %{<form action="#{tag.locals.page.url}" method="post">
        #{tag.expand}
      </form>}
  end

  %W{recipient_first_name recipient_middle_name recipient_last_name recipient_dob recipient_address recipient_city recipient_zip recipient_county recipient_school recipient_school_district recipient_parent_first_name recipient_parent_last_name recipient_phone referral_first_name referral_middle_name referral_last_name referral_title referral_organization referral_address referral_city referral_zip referral_county referral_phone referral_email referral_relationship}.each do |method|
    desc %{
      Renders a #{method} input field

      *Usage:*
      <pre><code><r:bed_request:form:#{method} /></code></pre>
    }
    tag "bed_request:form:#{method}" do |tag|
      bed_request = tag.locals.page.last_bed_request
      value = (!bed_request.nil? ? bed_request.send(method) : '')
      %{<input type="text" name="bed_request[#{method}]" value="#{value}" />}
    end
  end


  desc %{
    Renders a comments input field

    *Usage:*
    <pre><code><r:bed_request:form:comments /></code></pre>
  }
  tag "bed_request:form:comments" do |tag|
    bed_request = tag.locals.page.last_bed_request
    value = (!bed_request.nil? ? bed_request.send(method) : '')
    %{<textarea cols="50" name="bed_request[comments]" rows="10" value="#{value}"></textarea>}
  end

  desc %{
    Renders a submit button for all dis bed request stuff.

    *Usage:*
    <pre><code><r:bed_request:submit /></code></pre>
  }
  tag 'bed_request:form:submit' do |tag|
    bed_request = tag.locals.page.last_bed_request
    %{<input type="submit" value="Create" name="commit" />}
  end

  desc %{
    Expands inner tags if the bed request isn't valid.

    *Usage:*
    <pre><code><r:bed_request:if_error>...</r:bed_request:if_error></code></pre>
  }
  tag 'bed_request:if_error' do |tag|
    bed_request = tag.locals.page.last_bed_request
    attribute = tag.attr.delete('on')
    unless bed_request.nil? or bed_request.valid?
      if attribute
        if error = bed_request.errors.on(attribute.to_sym)
          tag.locals.error = error
          return tag.expand
        else
          return
        end
      end
      tag.locals.error = bed_request.errors
      tag.expand
    end
  end

  tag 'bed_request:errors' do |tag|
    tag.expand
  end

  desc %{
    Iterates through each error message.

    *Usage:*
    <pre><code><r:bed_request:errors:each>...</r:bed_request:errors:each></code></pre>
  }
  tag 'bed_request:errors:each' do |tag|
    rv = []
    tag.locals.error.full_messages.each do |m|
      tag.locals.error_message = m
      rv << tag.expand
    end
    rv
  end

  desc %{
    Renders an error message.

    *Usage:*
    <pre><code><r:bed_request:error_message /></code></pre>
  }
  tag 'bed_request:error_message' do |tag|
    tag.locals.error_message
  end

  desc %{
    Expands inner tags if the bed_request was created successfully.

    *Usage:*
    <pre><code><r:bed_request:if_success>...</r:bed_request:if_success></code></pre>
  }
  tag 'bed_request:if_success' do |tag|
    bed_request = tag.locals.page.last_bed_request
    tag.expand if bed_request and !bed_request.new_record?
  end

  desc %{
    Expands inner tags if the bed_request has not been saved (a new signup).

    *Usage:*
    <pre><code><r:bed_request:unless_success>...</r:bed_request:unless_success></code></pre>
  }
  tag 'bed_request:unless_success' do |tag|
    bed_request = tag.locals.page.last_bed_request
    tag.expand if bed_request.nil? or (bed_request and bed_request.new_record?)
  end

end
