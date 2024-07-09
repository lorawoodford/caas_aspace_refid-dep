# CAAS Aspace Ref_id Plugin

** Very much still WIP **

Plugin used to auto-increment archival object `ref_id`s per Smithsonian guidelines.  Namely:

```
[EADID]_ref[auto-incrementing number]
```
or
```
NMAH.AC.0001_ref1
```

Assumptions
* Since we're currently working from a db-based approach, we'll probably want to stick with something similar (albeit simplified).  We need to know what the starting increment is for each resource, and we've already got that in the sql-lite(?) db.  Rather than do slow/under-performant processes across large collections to get the last current increment, we can just start from what's in the existing db.

Working
* posting to `/caas_next_refid` endpoint with required resource_id param will increment `next_refid` in the db
* getting from `/caas_aspace_refid` will return all current ref_id objects

To do:
* Modify built in ref_id plugin or extend our own to make use of these increments.
* Validations
* Add permissions for new endpoints
* Tests!
* Linting/cleanup

Running tests:

From archivesspace project directory:
`./build/run backend:test -Dspec="../../plugins/caas_aspace_refid"`
