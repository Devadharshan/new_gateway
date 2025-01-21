SELECT
    task.number AS task_number,                 -- Task number
    task.short_description,                    -- Short description of the task
    task.catalog_type AS catalog_item,         -- Catalog item of the ticket
    task.close_notes,                          -- Close notes field
    task.assigned_to,                          -- Assigned to user
    task.assignment_group,                     -- Assignment group responsible
    task.sys_created_on AS opened_at,          -- When the ticket was opened
    task.closed_at,                            -- When the ticket was closed
    task.requester AS request_number,          -- Request number
    -- Calculated Fields
    CASE
        WHEN task.closed_at IS NOT NULL THEN TIMESTAMPDIFF(SECOND, task.sys_created_on, task.closed_at)
        ELSE NULL
    END AS time_to_close_seconds,              -- Time to close in seconds
    CASE
        WHEN task.closed_at IS NOT NULL THEN TIMESTAMPDIFF(HOUR, task.sys_created_on, task.closed_at) / 24
        ELSE NULL
    END AS time_to_close_days,                 -- Time to close in days
    -- Extracting chapter name from close notes
    SUBSTRING_INDEX(task.close_notes, ':', 1) AS chapter_name -- Assuming chapter name is before a colon
FROM
    v_task AS task
WHERE
    task.assignment_group IN ('GroupA', 'GroupB', 'GroupC') -- Replace with your assignment groups
    AND task.state IN ('Closed', 'Resolved')               -- Only include closed or resolved tickets
    AND task.sys_class_name = 'task';                      -- Ensure you're querying tasks
