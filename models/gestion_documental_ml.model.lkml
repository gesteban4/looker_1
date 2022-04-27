# Define the database connection to be used for this model.
connection: "gestion_documental"

# include all the views
include: "/views/**/*.view"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: gestion_documental_ml_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: gestion_documental_ml_default_datagroup

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Gestion Documental Ml"

explore: category {
  join: document {
    type: left_outer
    sql_on: ${category.document_id} = ${document.document_id} ;;
    relationship: many_to_one
  }

  join: task {
    type: left_outer
    sql_on: ${document.task_id} = ${task.task_id} ;;
    relationship: many_to_one
  }

  join: extraction {
    type: left_outer
    sql_on: ${category.id}=${extraction.id} ;;
    relationship: one_to_one
  }
}

explore: document {
  join: task {
    type: left_outer
    sql_on: ${document.task_id} = ${task.task_id} ;;
    relationship: many_to_one
  }

  join: category {
    type: left_outer
    sql_on: ${category.document_id} = ${document.document_id} ;;
    relationship: many_to_one
}

  join: extraction {
    type: left_outer
    sql_on: ${extraction.document_id} = ${document.document_id} ;;
    relationship: one_to_many
  }

}

explore: extraction {
  join: document {
    type: left_outer
    sql_on: ${extraction.document_id} = ${document.document_id} ;;
    relationship: many_to_one
  }

  join: task {
    type: left_outer
    sql_on: ${document.task_id} = ${task.task_id} ;;
    relationship: many_to_one
  }
  }
