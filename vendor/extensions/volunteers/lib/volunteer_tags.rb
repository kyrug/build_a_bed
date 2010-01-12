module VolunteerTags
  include Radiant::Taggable

  tag 'volunteer' do |tag|
    tag.expand
  end

  desc %{
    Renders a volunteer signup form

    *Usage:*
    <pre><code><r:volunteer:form>...</r:volunteer:form></code></pre>
  }
  tag 'volunteer:form' do |tag|
    %{<form action="#{tag.locals.page.url}" method="post">
        #{tag.expand}
      </form>}
  end

  %W{first_name last_name phone email}.each do |method|
    desc %{
      Renders a #{method} input field

      *Usage:*
      <pre><code><r:volunteer:form:#{method} /></code></pre>
    }
    tag "volunteer:form:#{method}" do |tag|
      volunteer = tag.locals.page.last_volunteer
      value = (!volunteer.nil? ? volunteer.send(method) : '')
      %{<input type="text" name="volunteer[#{method}]" value="#{value}" />}
    end
  end

  desc %{
    Renders a job select field.

    *Usage:*
    <pre><code><r:volunteer:job_select /></code></pre>
  }
  tag 'volunteer:form:job_select' do |tag|
    volunteer = tag.locals.page.last_volunteer
    job = volunteer.job if volunteer
    html = ''
    html << '<select name="volunteer[job_id]" id="volunteer" onchange="show(this)">'
    Job.all.each do |j|
      html << %{ <option value="#{j.id}"#{' selected' if job}>#{j.name}</option>}
    end
    html << '</select>'
    html
  end

  desc %{
    Renders a job description field.

    *Usage:*
    <pre><code><r:volunteer:job_description /></code></pre>
  }
  tag 'volunteer:form:job_description' do |tag|
    volunteer = tag.locals.page.last_volunteer
    job = volunteer.job if volunteer
    html = ''
    Job.all.each do |j|
      html << "<div id='vol_desc_#{j.id}' style='display:none'>"
      html << j.description if j.description
      html << '</div>'
    end
    html
  end



  desc %{
    Renders a submit button for all dis job signup stuff.

    *Usage:*
    <pre><code><r:volunteer:submit /></code></pre>
  }
  tag 'volunteer:form:submit' do |tag|
    volunteer = tag.locals.page.last_volunteer
    %{<input type="submit" value="Create" name="commit" />}
  end

  desc %{
    Expands inner tags if the volunteer isn't valid.

    *Usage:*
    <pre><code><r:volunteer:if_error>...</r:volunteer:if_error></code></pre>
  }
  tag 'volunteer:if_error' do |tag|
    volunteer = tag.locals.page.last_volunteer
    attribute = tag.attr.delete('on')
    unless volunteer.nil? or volunteer.valid?
      if attribute
        if error = volunteer.errors.on(attribute.to_sym)
          tag.locals.error = error
          return tag.expand
        else
          return
        end
      end
      tag.locals.error = volunteer.errors
      tag.expand
    end
  end

  tag 'volunteer:errors' do |tag|
    tag.expand
  end

  desc %{
    Iterates through each error message.

    *Usage:*
    <pre><code><r:volunteer:errors:each>...</r:volunteer:errors:each></code></pre>
  }
  tag 'volunteer:errors:each' do |tag|
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
    <pre><code><r:volunteer:error_message /></code></pre>
  }
  tag 'volunteer:error_message' do |tag|
    tag.locals.error_message
  end

  desc %{
    Expands inner tags if the volunteer was created successfully.

    *Usage:*
    <pre><code><r:volunteer:if_success>...</r:volunteer:if_success></code></pre>
  }
  tag 'volunteer:if_success' do |tag|
    volunteer = tag.locals.page.last_volunteer
    tag.expand if volunteer and !volunteer.new_record?
  end

  desc %{
    Expands inner tags if the volunteer has not been saved (a new signup).

    *Usage:*
    <pre><code><r:volunteer:unless_success>...</r:volunteer:unless_success></code></pre>
  }
  tag 'volunteer:unless_success' do |tag|
    volunteer = tag.locals.page.last_volunteer
    tag.expand if volunteer.nil? or (volunteer and volunteer.new_record?)
  end

end
