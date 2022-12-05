hugo --baseURL https://blog.coze.org/

s3deploy -force \
	 -source public \
	 -acl='public-read' \
	 -bucket ${AWS_BUCKET_NAME} \
	 -region ${AWS_REGION} \
	 -key ${AWS_ACCESS_KEY} \
	 -secret ${AWS_SECRET_KEY} \
	 -distribution-id ${AWS_DIST_ID}
