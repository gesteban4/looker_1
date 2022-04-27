# The name of this view in Looker is "Document"
view: document {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: analytics_ml.document ;;
  drill_fields: [document_id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: document_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.documentId ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Category" in Explore.

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: category_success {
    type: yesno
    sql: ${TABLE}.categorySuccess ;;
  }

  dimension: end_page {
    type: number
    sql: ${TABLE}.endPage ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_end_page {
    type: sum
    sql: ${end_page} ;;
  }

  measure: average_end_page {
    type: average
    sql: ${end_page} ;;
    value_format: "0.00"
  }

  dimension: error_details {
    type: string
    sql: ${TABLE}.errorDetails ;;
  }

  dimension: extraction_success {
    type: string
    sql: ${TABLE}.extractionSuccess ;;
  }

  dimension: init_page {
    type: number
    sql: ${TABLE}.initPage ;;
  }

  dimension: success {
    type: string
    sql: ${TABLE}.success ;;
  }

  dimension: task_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.taskId ;;
  }

  measure: count {
    type: count
    drill_fields: [document_id, task.task_id, category.count, extraction.count]
  }

  measure: ficheros_recibidos {
    type: number
    sql: count(distinct ${TABLE}.documentId) ;;
  }

  measure: ficheros_validos {
    type: number
    sql: count(distinct ${TABLE}.documentId)-count(${TABLE}.errorDetails) ;;
  }

  measure: porcentaje_ficheros_validos {
    type: number
    sql: ${ficheros_validos}/${ficheros_recibidos} ;;
    value_format: "0.00%"
  }



 dimension: t_clasificados {
   type: number
  sql: (
  case when ${category_success} = "true" then 1 end
  ) ;;
 }

measure: ficheros_clasificados2 {
  type: number
  sql: count(${t_clasificados}) ;;
   }

  measure: porcentaje_clasificados2 {
    type: number
    sql: ${ficheros_clasificados2}/${ficheros_recibidos} ;;
    value_format: "0.00%"
  }


  measure: suma_clasificados {
    type: number
    sql: (select count(categorySuccess) from `document` where categorySuccess = "true") ;;
  }

  measure: porcentaje_clasificados {
    type: number
    sql: ${suma_clasificados}/${ficheros_recibidos} ;;
    value_format: "0.00%"
  }

  measure: suma_extraidos {
    type: number
    sql: (select count(extractionSuccess) from `document` where extractionSuccess = "true") ;;
  }

  measure: porcentaje_extraidos {
    type: number
    sql: ${suma_extraidos}/${ficheros_recibidos} ;;
    value_format: "0.00%"
  }

  measure: suma_exitos {
    type: number
    sql: (select count(success) from `document` where success = "true") ;;
  }

  measure: porcentaje_exitos {
    type: number
    sql: ${suma_exitos}/${ficheros_recibidos} ;;
    value_format: "0.00%"
  }

  measure: suma_paginas {
    type: number
    sql: sum(${end_page}) ;;
  }

  measure: paginas_por_documento {
    type: number
    sql: ${suma_paginas}/${suma_clasificados} ;;
    value_format: "0.00"
  }

  measure: n_categorias {
    type: count_distinct
    sql: ${category} ;;
    drill_fields: [category]
  }

}
