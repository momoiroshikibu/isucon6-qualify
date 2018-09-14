# alp
ALP_COMMAND=".logs/nginx/access.log"
alp.sort.by.max.response.time:
	cat $(ALP_COMMAND) | alp --max

alp.sort.by.max.response.time.reverse:
	cat $(ALP_COMMAND) | alp --max --reverse

alp.sort.by.min.response.time:
	cat $(ALP_COMMAND) | alp --min

alp.sort.by.min.response.time.reverse:
	cat $(ALP_COMMAND) | alp --min --reverse

alp.sort.by.avg.response.time:
	cat $(ALP_COMMAND) | alp --avg

alp.sort.by.avg.response.time.reverse:
	cat $(ALP_COMMAND) | alp --avg --reverse

alp.sort.by.sum.response.time:
	cat $(ALP_COMMAND) | alp --sum

alp.sort.by.sum.response.time.reverse:
	cat $(ALP_COMMAND) | alp --sum --reverse

alp.sort.by.count:
	cat $(ALP_COMMAND) | alp --cnt

alp.sort.by.count.reverse:
	cat $(ALP_COMMAND) | alp --cnt --reverse

alp.sort.by.uri:
	cat $(ALP_COMMAND) | alp --uri

alp.sort.by.uri.reverse:
	cat $(ALP_COMMAND) | alp --uri --reverse

alp.sort.by.method:
	cat $(ALP_COMMAND) | alp --method

alp.sort.by.method.reverse:
	cat $(ALP_COMMAND) | alp --method --reverse

alp.sort.by.max.body.size:
	cat $(ALP_COMMAND) | alp --max-body

alp.sort.by.max.body.size.reverse:
	cat $(ALP_COMMAND) | alp --max-body --reverse

alp.sort.by.min.body.size:
	cat $(ALP_COMMAND) | alp --min-body

alp.sort.by.min.body.size.reverse:
	cat $(ALP_COMMAND) | alp --min-body --reverse

alp.sort.by.avg.body.size:
	cat $(ALP_COMMAND) | alp --avg-body

alp.sort.by.avg.body.size.reverse:
	cat $(ALP_COMMAND) | alp --avg-body --reverse

alp.sort.by.sum.body.size:
	cat $(ALP_COMMAND) | alp --sum-body

alp.sort.by.sum.body.size.reverse:
	cat $(ALP_COMMAND) | alp --sum-body --reverse

alp.sort.by.1.percentail.response.time:
	cat $(ALP_COMMAND) | alp --p1

alp.sort.by.1.percentail.response.time.reverse:
	cat $(ALP_COMMAND) | alp --p1 --reverse

alp.sort.by.50.percentail.response.time:
	cat $(ALP_COMMAND) | alp --p50

alp.sort.by.50.percentail.response.time.reverse:
	cat $(ALP_COMMAND) | alp --p50 --reverse

alp.sort.by.99.percentail.response.time:
	cat $(ALP_COMMAND) | alp --p99

alp.sort.by.99.percentail.response.time.reverse:
	cat $(ALP_COMMAND) | alp --p99 --reverse

alp.sort.by.standard.deviation.response.time:
	cat $(ALP_COMMAND) | alp --stddev

alp.sort.by.standard.deviation.response.time.reverse:
	cat $(ALP_COMMAND) | alp --stddev --reverse
