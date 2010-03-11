module DonationTags
  include Radiant::Taggable

  tag 'donation' do |tag|
    tag.expand
  end

  desc %{
    Renders a donation signup form

    *Usage:*
    <pre><code><r:donation:form>...</r:donation:form></code></pre>
  }
  tag 'donation:form' do |tag|
    %{<form action="#{tag.locals.page.url}" method="post">
        #{tag.expand}
      </form>}
  end

  %W{first_name last_name phone email quantity}.each do |method|
    desc %{
      Renders a #{method} input field

      *Usage:*
      <pre><code><r:donation:form:#{method} /></code></pre>
    }
    tag "donation:form:#{method}" do |tag|
      donation = tag.locals.page.last_donation
      value = (!donation.nil? ? donation.send(method) : '')
      %{<input type="text" name="donation[#{method}]" value="#{value}" />}
    end
  end

  desc %{
    Renders a donation request select field.

    *Usage:*
    <pre><code><r:donation:donation_request_select /></code></pre>
  }
  tag 'donation:form:donation_request_select' do |tag|
    donation = tag.locals.page.last_donation
    donation_request = donation.donation_request if donation 
    html = ''
    html << '<select name="donation[donation_request_id]">'
    DonationRequest.all.each do |r|
      html << %{ <option value="#{r.id}"#{' selected' if donation_request}>#{r.name}</option>} unless r.filled?
    end
    html << '</select>'
    html
  end

  desc %{
    Renders a submit button for all dis donation request signup stuff.

    *Usage:*
    <pre><code><r:donation:submit /></code></pre>
  }
  tag 'donation:form:submit' do |tag|
    donation = tag.locals.page.last_donation
    %{<input type="submit" value="Create" name="commit" />}
  end

  desc %{
    Expands inner tags if the donation isn't valid.

    *Usage:*
    <pre><code><r:donation:if_error>...</r:donation:if_error></code></pre>
  }
  tag 'donation:if_error' do |tag|
    donation = tag.locals.page.last_donation
    attribute = tag.attr.delete('on')
    unless donation.nil? or donation.valid?
      if attribute
        if error = donation.errors.on(attribute.to_sym)
          tag.locals.error = error
          return tag.expand
        else
          return
        end
      end
      tag.locals.error = donation.errors
      tag.expand
    end
  end

  tag 'donation:errors' do |tag|
    tag.expand
  end

  desc %{
    Iterates through each error message.

    *Usage:*
    <pre><code><r:donation:errors:each>...</r:donation:errors:each></code></pre>
  }
  tag 'donation:errors:each' do |tag|
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
    <pre><code><r:donation:error_message /></code></pre>
  }
  tag 'donation:error_message' do |tag|
    tag.locals.error_message
  end

  desc %{
    Expands inner tags if the donation was created successfully.

    *Usage:*
    <pre><code><r:donation:if_success>...</r:donation:if_success></code></pre>
  }
  tag 'donation:if_success' do |tag|
    donation = tag.locals.page.last_donation
    tag.expand if donation and !donation.new_record?
  end

  desc %{
    Expands inner tags if the donation has not been saved (a new signup).

    *Usage:*
    <pre><code><r:donation:unless_success>...</r:donation:unless_success></code></pre>
  }
  tag 'donation:unless_success' do |tag|
    donation = tag.locals.page.last_donation
    tag.expand if donation.nil? or (donation and donation.new_record?)
  end

end
