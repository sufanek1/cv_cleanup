#!/bin/bash
list=$(sudo -u foreman psql -d foreman -t -c 'select katello_content_view_versions.id from katello_content_view_versions left join katello_content_view_environments on (katello_content_view_versions.id = katello_content_view_environments.content_view_version_id) where katello_content_view_environments.id IS NULL;')

for i in $list
do
  echo "deleting cv_version id $i"
  hammer content-view version delete --id $i
done
