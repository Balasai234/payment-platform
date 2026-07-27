FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY target/payment-service-0.0.1-SNAPSHOT.jar app.jar
COPY opentelemetry-javaagent.jar /otel/opentelemetry-javaagent.jar

EXPOSE 8080

ENTRYPOINT [
  "java",
  "-javaagent:/otel/opentelemetry-javaagent.jar",
  "-Dotel.javaagent.debug=true",
  "-Dotel.service.name=payment-platform",
  "-Dotel.exporter.otlp.endpoint=http://otel-collector-opentelemetry-collector.observability.svc.cluster.local:4317",
  "-Dotel.exporter.otlp.protocol=grpc",
  "-Dotel.metrics.exporter=otlp",
  "-Dotel.traces.exporter=otlp",
  "-Dotel.logs.exporter=otlp",
  "-jar",
  "app.jar"
]
