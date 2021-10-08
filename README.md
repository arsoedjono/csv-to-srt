# CSV to SRT Script

## How to Use

```
ruby main.rb "path/to/csv.csv"
```

It will produce .srt files for Bahasa Indonesia (`-id`) and English (`-en`) in the same folder as the CSV file.

## Boundaries

- CSV must have following headers

```csv
s_hour,s_minute,s_second,s_msecond,e_hour,e_minute,e_second,e_msecond,text_*
```

> prefix `s_`: starting time
>
> prefix `e_`: end time
>
> `text_*`: languages provided, it can be multiple by separating it with comma, e.g. `...,text_id,text_en`

- Empty time will be converted to 0
- Time will have leading zeros, if necessary
