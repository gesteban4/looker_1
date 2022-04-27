# The name of this view in Looker is "Category"
view: category {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: analytics_ml.category ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Category" in Explore.

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: confidence {
    type: number
    sql: ${TABLE}.confidence ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_confidence {
    type: sum
    sql: ${confidence} ;;
  }

  measure: average_confidence {
    type: average
    sql: ${confidence} ;;
  }

  dimension: document_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.documentId ;;
  }

  measure: count {
    type: count
    drill_fields: [id, document.document_id]
  }

  measure: count_distinct_category {
    type: number
    sql: (select count(distinct ${id}) from `category`);;
  }
}
