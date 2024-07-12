# CAAS Aspace Ref_id Plugin

**Very much still WIP**

Plugin used to auto-increment archival object `ref_id`s per Smithsonian guidelines.  Namely:

```
[EADID]_ref[auto-incrementing number]
```
or
```
NMAH.AC.0001_ref1
```

Assumptions
* Since we're currently working from a db-based approach, we'll probably want to stick with something similar (albeit simplified).  We need to know what the starting increment is for each resource, and we've already got that in the sql-lite(?) db.  Rather than do slow/under-performant processes across large collections to get the last current increment, we can just start from what's in the existing db.  When it comes time to implement this plugin in production, we should seed the plugin-created `caas_aspace_refid` table with the appropriate last increment for each collection.

Working
* posting to `/plugins/caas_next_refid` endpoint with required resource_id param will increment `next_refid` in the db
* creating first archival object in new resource will start with increment of 1
* increments added to new `caas_aspace_refid` table
* db schema changes tracked in `caas_aspace_refid_schema` table
* adding a new archival object to an existing resource via the staff ui will increment to the next number/starting number of 1

To do:
* Modify built in ref_id plugin or extend our own to make use of these increments?
    * Seemed too complicated with limited ROI to pass our plugin logic to another optional program-maintained plugin.  Just doing it all in one caas-specific plugin
* Validations
* Add permissions for new endpoints
    * Overkill?  Have to attend to the fact that permissions are all repo scoped, but this will be a globally available endpoint.
* ~~Tests!~~
* Linting/cleanup

Decisions
* What to do when an EADID is not present in the resource record?  Current legacy plugin just falls back to blank (so, ref_id would be something like `_ref123`)
* What to do if something goes awry in generating the increment?  Current legacy plugin uses a datestamp fall back.

Still thinking:
* Manual way to update all ref_ids if something goes awry?

Running tests:

From archivesspace project directory:
`./build/run backend:test -Dspec="../../plugins/caas_aspace_refid"`
