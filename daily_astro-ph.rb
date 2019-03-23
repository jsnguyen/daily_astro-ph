#!/usr/bin/ruby

require 'rss'
require 'optparse'
require 'time'

class String
    def black;          "\e[30m#{self}\e[0m" end
    def red;            "\e[31m#{self}\e[0m" end
    def green;          "\e[32m#{self}\e[0m" end
    def brown;          "\e[33m#{self}\e[0m" end
    def blue;           "\e[34m#{self}\e[0m" end
    def magenta;        "\e[35m#{self}\e[0m" end
    def cyan;           "\e[36m#{self}\e[0m" end
    def gray;           "\e[37m#{self}\e[0m" end

    def bg_black;       "\e[40m#{self}\e[0m" end
    def bg_red;         "\e[41m#{self}\e[0m" end
    def bg_green;       "\e[42m#{self}\e[0m" end
    def bg_brown;       "\e[43m#{self}\e[0m" end
    def bg_blue;        "\e[44m#{self}\e[0m" end
    def bg_magenta;     "\e[45m#{self}\e[0m" end
    def bg_blue;        "\e[46m#{self}\e[0m" end
    def bg_gray;        "\e[47m#{self}\e[0m" end

    def bold;           "\e[1m#{self}\e[22m" end
    def italic;         "\e[3m#{self}\e[23m" end
    def underline;      "\e[4m#{self}\e[24m" end
    def blink;          "\e[5m#{self}\e[25m" end
    def reverse_color;  "\e[7m#{self}\e[27m" end
end

filenames = ['CO.cache', \
             'EP.cache', \
             'GA.cache', \
             'HE.cache', \
             'IM.cache', \
             'SR.cache'  ]

names = ['Cosmology and Nongalactic Astrophysics', \
         'Earth and Planetary Astrophysics', \
         'Astrophysics of Galaxies', \
         'High Energy Astrophysical Phenomena', \
         'Instrumentation and Methods for Astrophysics', \
         'Solar and Stellar Astrophysics']

options = {}
options[:page]=1
options[:entries]=5
OptionParser.new do |opts|
    opts.banner = "Usage: daily-astro-ph.rb [options]"

    opts.on("-s", "--suppress_summary","suppresses the summary") do |s|
        options[:suppress_summary] = s
    end

    opts.on("-p[PAGE]", "--page=[PAGE]",Integer,"get page given number of entries") do |page|
        options[:page] = page
    end

    opts.on("-e[ENTRY]", "--entries=[ENTRY]",Integer,"number of entries to list") do |entry|
        options[:entries] = entry 
    end
end.parse!

max_author=5
filenames.each_with_index do |fn,i|
    feed = RSS::Parser.parse(open(fn))
    puts names[i].cyan.underline
    puts

    starting  = (options[:page]-1)*options[:entries]
    ending = options[:entries]

    feed.items.slice(starting,ending).each_with_index do |el,j|
        date = Time.parse(el.updated.content.to_s)
        print ("("+(starting+j+1).to_s+") ").green
        print (date.month.to_s+'-'+date.day.to_s+'-'+date.year.to_s+' ').green
        puts (el.id.content.gsub("abs","pdf")+".pdf").green
        puts el.title.content.gsub("\n",'').squeeze(' ').red

        el.authors.each_with_index do |au,k|
            if k > max_author
                print ','+' et al.'.blue
                break
            end
            if k!=0
                print ', '
            end
            print au.name.content.blue
        end
        puts
        if !options[:suppress_summary]
            puts el.summary.content
        end
        puts
    end
end
