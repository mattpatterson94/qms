defmodule Qms.Spotify.Authorization do
  def token(url) do
    token = "some_token_from_another_request"
    url = "https://example.com/api/endpoint_that_needs_a_bearer_token"
    headers = ["Authorization": "Bearer #{token}", "Accept": "Application/json; Charset=utf-8"]
    options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 500]
    {:ok, response} = HTTPoison.get(url, headers, options)


    HTTPoison.post url, "{}", [{"Content-Type", "application/json"}]
      {:ok, %HTTPoison.Response{body: "{\n  \"args\": {},\n  \"headers\": {\n    \"host\": \"httparrot.herokuapp.com\",\n    \"connection\": \"close\",\n    \"accept\": \"application/json\",\n    \"content-type\": \"application/json\",\n    \"user-agent\": \"hackney/1.6.1\",\n    \"x-request-id\": \"4b85de44-6227-4480-b506-e3b9b4f0318a\",\n    \"x-forwarded-for\": \"76.174.231.199\",\n    \"x-forwarded-proto\": \"http\",\n    \"x-forwarded-port\": \"80\",\n    \"via\": \"1.1 vegur\",\n    \"connect-time\": \"1\",\n    \"x-request-start\": \"1475945832992\",\n    \"total-route-time\": \"0\",\n    \"content-length\": \"16\"\n  },\n  \"url\": \"http://httparrot.herokuapp.com/post\",\n  \"origin\": \"10.180.37.142\",\n  \"form\": {},\n  \"data\": \"{\\\"body\\\": \\\"test\\\"}\",\n  \"json\": {\n    \"body\": \"test\"\n  }\n}",
          headers: [{"Connection", "keep-alive"}, {"Server", "Cowboy"},
          {"Date", "Sat, 08 Oct 2016 16:57:12 GMT"}, {"Content-Length", "681"},
          {"Content-Type", "application/json"}, {"Via", "1.1 vegur"}],
      status_code: 200}}

    %{
      "access_token" => "asdjnjkasndjksankjsd",
      "refresh_token" => "12222asxcqsdasdsa",
      "expires_in" => Timex.now
    }
  end
end
