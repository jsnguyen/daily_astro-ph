require 'net/http'
require 'uri'

max_results=100

urls = ['http://export.arxiv.org/api/query?search_query=cat:astro-ph.CO&start=0&max_results='+max_results.to_s+'&sortBy=lastUpdatedDate&sortOrder=descending', \
        'http://export.arxiv.org/api/query?search_query=cat:astro-ph.EP&start=0&max_results='+max_results.to_s+'&sortBy=lastUpdatedDate&sortOrder=descending', \
        'http://export.arxiv.org/api/query?search_query=cat:astro-ph.GA&start=0&max_results='+max_results.to_s+'&sortBy=lastUpdatedDate&sortOrder=descending', \
        'http://export.arxiv.org/api/query?search_query=cat:astro-ph.HE&start=0&max_results='+max_results.to_s+'&sortBy=lastUpdatedDate&sortOrder=descending', \
        'http://export.arxiv.org/api/query?search_query=cat:astro-ph.IM&start=0&max_results='+max_results.to_s+'&sortBy=lastUpdatedDate&sortOrder=descending', \
        'http://export.arxiv.org/api/query?search_query=cat:astro-ph.SR&start=0&max_results='+max_results.to_s+'&sortBy=lastUpdatedDate&sortOrder=descending'  ]

filenames = ['CO.cache', \
             'EP.cache', \
             'GA.cache', \
             'HE.cache', \
             'IM.cache', \
             'SR.cache'  ]

urls.each_with_index do |el,i|
    puts 'Writing '+filenames[i]+'...'
    url = URI.parse(el)
    res = Net::HTTP.get_response(url)
    File.open(filenames[i], 'w'){ |file| file.write(res.body) }
end

puts 'Done.'

