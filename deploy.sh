
hugo --baseURL https://blog.coze.org/

s3deploy -force \
	 -source public \
	 -bucket ${AWS_BUCKET_NAME} \
	 -key ${AWS_ACCESS_KEY} \
	 -secret ${AWS_SECRET_KEY} \
	 -region ${AWS_REGION}
