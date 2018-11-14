view: looker_sample {
  sql_table_name: cdp_analytics.looker_sample ;;

  dimension: dname {
    type: string
    sql: ${TABLE}.dname ;;
  }

  dimension_group: run {
    type: time
    timeframes: [
      day_of_month,day_of_year,raw,time,date,
      week,month,quarter,year
    ]
    sql: ${TABLE}.run_date ;;
  }

  measure: salary {
    type: sum
    sql: ${TABLE}.salary ;;
  }

dimension: created_date {
  type: date_time_of_day
  sql: ${run_date} ;;
  }

  dimension: created_month {
    type: date_day_of_month
    sql: ${run_date} ;;
  }

  dimension: created_quarter {
    type: date_fiscal_quarter
    sql: ${run_date} ;;
  }
  dimension: created_year {
    type: date_day_of_year
    sql: ${run_date} ;;
  }

  parameter: date_granularity {
    type: string
    allowed_value: { value: "Day" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Quarter" }
    allowed_value: { value: "Year" }
  }


  dimension: date {
    label_from_parameter: date_granularity
    sql:
    CASE
    WHEN {% parameter date_granularity %} = 'Day' THEN ${created_date}
    WHEN {% parameter date_granularity %} = 'Month' THEN ${created_month}
    WHEN {% parameter date_granularity %} = 'Quarter' THEN ${created_quarter}
    WHEN {% parameter date_granularity %} = 'Year' THEN ${created_year}
    ELSE NULL
  END ;;
  }





}
