First run 
```
./get_astro-ph.rb
```
to get 100 entries for each category from the ArXiv and cache them locally.

Then run
```
./daily_astro-ph.rb [OPTIONS]
```
Default values are 5 entries per category, displaying the first page, no summary suppression. Run with "-h" to get options.
