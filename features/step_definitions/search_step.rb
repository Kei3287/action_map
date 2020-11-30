When /^(?:|I )submit "([^"]*)"$/ do |button|
  stub_request(:get, /.*civicinfo*/).to_return(
    headers: [['Content-Type', 'application/json; charset=UTF-8']],
    body:    File.read(File.join('google_civic_api.json'))
  )
  click_button(button)
end
