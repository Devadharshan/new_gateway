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
