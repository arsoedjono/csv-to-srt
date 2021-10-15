# CSV to SRT Script

## How to Use

```
rake csv_to_srt -- --file path/to/csv.csv
```

It will produce .srt files for languages you have set in the CSV file within the same folder as the target CSV file.

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

## Testing

Run this command to execute the unit test

```bash
rspec
```
