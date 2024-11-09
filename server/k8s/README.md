# Kubernetes deployment

## Load test
In order to test autoscaling we can run a load test:
1. Run this in a separate terminal so that the load generation continues, and you can carry on with the rest of the
   steps
   ```bash
   kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://34.140.200.18/ping; done"
   ```
2. Watch the horizontal pod autoscaler:
   ```bash
   kubectl get hpa connectivity-test-server --watch
   ```
   The expected result is that the HPA scales up and down pods accordingly to cpu usage (keep in mind this can take a
   few minutes):
   ```
   NAME                       REFERENCE                             TARGETS        MINPODS   MAXPODS   REPLICAS   AGE
   connectivity-test-server   Deployment/connectivity-test-server   cpu: 2%/50%    3         10        3          2m31s
   connectivity-test-server   Deployment/connectivity-test-server   cpu: 16%/50%   3         10        3          2m47s
   connectivity-test-server   Deployment/connectivity-test-server   cpu: 27%/50%   3         10        3          3m17s
   connectivity-test-server   Deployment/connectivity-test-server   cpu: 27%/50%   3         10        3          4m17s
   connectivity-test-server   Deployment/connectivity-test-server   cpu: 43%/50%   3         10        3          5m17s
   connectivity-test-server   Deployment/connectivity-test-server   cpu: 69%/50%   3         10        3          5m47s
   connectivity-test-server   Deployment/connectivity-test-server   cpu: 69%/50%   3         10        5          6m2s
   connectivity-test-server   Deployment/connectivity-test-server   cpu: 46%/50%   3         10        5          6m47s
   connectivity-test-server   Deployment/connectivity-test-server   cpu: 44%/50%   3         10        5          7m48s
   # After stopping the load
   connectivity-test-server   Deployment/connectivity-test-server   cpu: 43%/50%   3         10        5          8m48s
   connectivity-test-server   Deployment/connectivity-test-server   cpu: 10%/50%   3         10        5          9m48s
   connectivity-test-server   Deployment/connectivity-test-server   cpu: 2%/50%    3         10        5          10m
   connectivity-test-server   Deployment/connectivity-test-server   cpu: 2%/50%    3         10        5          14m
   connectivity-test-server   Deployment/connectivity-test-server   cpu: 2%/50%    3         10        3          14m
   connectivity-test-server   Deployment/connectivity-test-server   cpu: 2%/50%    3         10        3          15m
   ```
