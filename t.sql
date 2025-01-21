SELECT
    vt.number_ AS task_number,                       -- Task number
    vt.state_ AS task_state,                        -- Task state
    vt.assignment_group,                            -- Assignment group
    vt.assigned_to,                                 -- Assigned user
    vt.opened_at,                                   -- Task open time
    vt.closed_at,                                   -- Task close time
    DATEDIFF(SECOND, vt.opened_at, vt.closed_at) / 3600.0 AS time_to_close_hours, -- Time to close (in hours)
    vt.closed_notes,                                -- Close notes
    vt.short_description,                           -- Task short description
    sri.cat_item AS catalog_item,                   -- Catalog item
    sr.number AS request_number                     -- Request number
FROM
    v_task vt
LEFT JOIN
    sc_req_item sri ON vt.sys_id = sri.task         -- Join sc_req_item via task reference
LEFT JOIN
    sc_request sr ON sri.request = sr.sys_id        -- Join sc_request for request number
WHERE
    vt.sys_created_on > DATEADD(YY, -3, GETDATE())  -- Filter: Last 3 years






SELECT
    vt.number_ AS task_number,                  -- Task number
    vt.state_ AS task_state,                   -- Task state
    vt.assignment_group,                       -- Assignment group
    vt.assigned_to,                            -- Assigned user
    vt.opened_at,                              -- Task open time
    vt.closed_at,                              -- Task close time
    DATEDIFF(HOUR, vt.opened_at, vt.closed_at) AS time_to_close_hours,  -- Time to close
    vt.closed_notes,                           -- Close notes
    vt.short_description,                      -- Task short description
    sri.cat_item AS catalog_item,              -- Catalog item
    sr.number AS request_number                -- Request number
FROM
    v_task vt
LEFT JOIN
    sc_req_item sri ON vt.sys_id = sri.task    -- Join sc_req_item via task reference
LEFT JOIN
    sc_request sr ON sri.request = sr.sys_id   -- Join sc_request for request number
WHERE
    vt.sys_created_on > DATEADD(YY, -3, GETDATE())  -- Last 3 years






SELECT
    vt.number_ AS task_number,                   -- Task number
    vt.state_ AS state,                          -- Task state
    vt.assignment_group,                         -- Assignment group
    vt.assigned_to,                              -- Assigned user
    vt.opened_at,                                -- When the task was opened
    vt.priority,                                 -- Task priority
    vt.short_description,                        -- Task short description
    vt.reassignment_count AS times_reassigned,   -- Times the task was reassigned
    vt.closed_at,                                -- When the task was closed
    vt.sys_updated_on,                           -- Last updated timestamp
    vt.sys_created_on,                           -- Created timestamp
    vt.u_reopened_count,                         -- Reopened count
    vt.active,                                   -- Task active status
    vt.cmdb_ci,                                  -- Configuration item
    vt.closed_notes,                             -- Close notes field
    sri.cat_item AS catalog_item,                -- Catalog item from sc_req_item
    sr.number AS request_number                  -- Request number from sc_request
FROM
    v_task vt
LEFT JOIN
    sc_request sr ON vt.sys_id = sr.sys_id        -- Join v_task with sc_request (if possible)
LEFT JOIN
    sc_req_item sri ON sr.sys_id = sri.request    -- Join sc_request with sc_req_item
WHERE
    vt.sys_created_on > DATEADD(YY, -3, GETDATE())  -- Filter tasks from the last 3 years









CREATE VIEW v_task_with_request AS
SELECT
    vt.number_ AS task_number,         -- Task number
    vt.short_description,             -- Short description of the task
    vt.catalog_type AS catalog_item,  -- Catalog item of the ticket
    vt.closed_notes AS close_notes,   -- Close notes field
    vt.assigned_to,                   -- Assigned to user
    vt.assignment_group,              -- Assignment group responsible
    vt.opened_at,                     -- When the ticket was opened
    vt.closed_at,                     -- When the ticket was closed
    vt.opened_by,                     -- User who opened the ticket
    vt.priority,                      -- Priority of the task
    vt.state_ AS state,               -- Current state of the task
    vt.sys_created_by,                -- User who created the task
    vt.sys_created_on,                -- Timestamp when the task was created
    vt.time_worked,                   -- Total time worked on the task
    vt.u_tags,                        -- Custom tags associated with the task
    sr.number AS request_number       -- Associated request number
FROM
    v_task vt
LEFT JOIN
    sc_req_item sri ON vt.sys_id = sri.task   -- Join with request item table
LEFT JOIN
    sc_request sr ON sri.request = sr.sys_id  -- Join with request table
WHERE
    vt.sys_class_name = 'task';               -- Ensure you're querying tasks only




SELECT
    vt.number AS task_number,                      -- Task number
    vt.state_ AS state,                           -- Task state
    vt.assignment_group,                          -- Assignment group
    vt.assigned_to,                               -- Assigned user
    vt.opened_at,                                 -- When the task was opened
    vt.priority,                                  -- Task priority
    vt.short_description,                         -- Task short description
    vt.reassignment_count AS times_reassigned,    -- Times the task was reassigned
    vt.closed_at,                                 -- When the task was closed
    vt.sys_updated_on,                            -- Last updated timestamp
    vt.sys_created_on,                            -- Created timestamp
    vt.u_reopened_count,                          -- Reopened count
    vt.active,                                    -- Task active status
    vt.cmdb_ci,                                   -- Configuration item
    vt.closed_notes,                              -- Close notes field
    vt.catalog_type AS catalog_item,              -- Catalog item field
    sr.number AS request_number                   -- Associated request number
FROM
    v_task vt
LEFT JOIN
    sc_req_item sri ON vt.sys_id = sri.task        -- Join v_task with sc_req_item
LEFT JOIN
    sc_request sr ON sri.request = sr.sys_id       -- Join sc_req_item with sc_request
WHERE
    vt.sys_created_on > DATEADD(YY, -3, GETDATE()) -- Filter tasks from the last 3 years




SELECT
    vt.number_ AS task_number,                   -- Task number
    vt.state_ AS state,                          -- Task state
    vt.assignment_group,                         -- Assignment group
    vt.assigned_to,                              -- Assigned user
    vt.opened_at,                                -- When the task was opened
    vt.priority,                                 -- Task priority
    vt.short_description,                        -- Task short description
    vt.reassignment_count AS times_reassigned,   -- Times the task was reassigned
    vt.closed_at,                                -- When the task was closed
    vt.sys_updated_on,                           -- Last updated timestamp
    vt.sys_created_on,                           -- Created timestamp
    vt.u_reopened_count,                         -- Reopened count
    vt.active,                                   -- Task active status
    vt.cmdb_ci,                                  -- Configuration item
    vt.closed_notes,                             -- Close notes field
    vt.catalog_type AS catalog_item,             -- Catalog item field
    sri.request AS request_number                -- Request number from sc_req_item
FROM
    v_task vt
LEFT JOIN
    sc_req_item sri ON vt.sys_id = sri.task       -- Join v_task with sc_req_item (task)
LEFT JOIN
    sc_request sr ON sri.request = sr.sys_id      -- Join sc_req_item with sc_request (request)
WHERE
    vt.sys_created_on > DATEADD(YY, -3, GETDATE())  -- Filter tasks from the last 3 years


SELECT
    vt.number_ AS task_number,                   -- Task number
    vt.state_ AS state,                          -- Task state
    vt.assignment_group,                         -- Assignment group
    vt.assigned_to,                              -- Assigned user
    vt.opened_at,                                -- When the task was opened
    vt.priority,                                 -- Task priority
    vt.short_description,                        -- Task short description
    vt.reassignment_count AS times_reassigned,   -- Times the task was reassigned
    vt.closed_at,                                -- When the task was closed
    vt.sys_updated_on,                           -- Last updated timestamp
    vt.sys_created_on,                           -- Created timestamp
    vt.u_reopened_count,                         -- Reopened count
    vt.active,                                   -- Task active status
    vt.cmdb_ci,                                  -- Configuration item
    vt.closed_notes,                             -- Close notes field
    sri.cat_item AS catalog_item,                -- Catalog item from sc_req_item
    sri.request AS request_number                -- Request number from sc_req_item
FROM
    v_task vt
LEFT JOIN
    sc_req_item sri ON vt.sys_id = sri.task      -- Join v_task with sc_req_item (task)
LEFT JOIN
    sc_request sr ON sri.request = sr.sys_id     -- Join sc_req_item with sc_request (request)
WHERE
    vt.sys_created_on > DATEADD(YY, -3, GETDATE())  -- Filter tasks from the last 3 years




SELECT
    vt.number_ AS task_number,                   -- Task number
    vt.state_ AS state,                          -- Task state
    vt.assignment_group,                         -- Assignment group
    vt.assigned_to,                              -- Assigned user
    vt.opened_at,                                -- When the task was opened
    vt.priority,                                 -- Task priority
    vt.short_description,                        -- Task short description
    vt.reassignment_count AS times_reassigned,   -- Times the task was reassigned
    vt.closed_at,                                -- When the task was closed
    vt.sys_updated_on,                           -- Last updated timestamp
    vt.sys_created_on,                           -- Created timestamp
    vt.u_reopened_count,                         -- Reopened count
    vt.active,                                   -- Task active status
    vt.cmdb_ci,                                  -- Configuration item
    vt.closed_notes,                             -- Close notes field
    sri.cat_item AS catalog_item,                -- Catalog item from sc_req_item
    sri.request AS request_number                -- Request number from sc_req_item
FROM
    v_task vt
LEFT JOIN
    sc_req_item sri ON vt.sys_id = sri.task      -- Join v_task with sc_req_item (via task reference)
LEFT JOIN
    sc_request sr ON sri.request = sr.sys_id     -- Join sc_req_item with sc_request (request)
WHERE
    vt.sys_created_on > DATEADD(YY, -3, GETDATE())  -- Filter tasks from the last 3 years