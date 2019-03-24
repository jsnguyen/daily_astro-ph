# Command Line Daily astro-ph Feed

First run 
```
./get_astro-ph.rb
```
to get 100 entries for each category from the ArXiv and cache them locally.

Then run
```
./daily_astro-ph.rb [OPTIONS]
```
Default values are 5 entries per category, displaying the first page, no summary suppression. Run with "-h" to get options. Can change the number of entries shown and which entries you want to read with the page number. Suppress the summary output if there is too much text.
