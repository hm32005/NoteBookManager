package bdp.sample.notebookmanager;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

public class NotebookApiLoadTester {
    private static final String API_URL = "http://localhost:8090/api/notebooks?page=0&pageSize=10"; // Change if needed
    private static final int NUM_REQUESTS = 1000; // Number of requests to send
    private static final int NUM_THREADS = 50;   // Number of concurrent threads

    public static void main(String[] args) throws InterruptedException {
        ExecutorService executor = Executors.newFixedThreadPool(NUM_THREADS);
        for (int i = 0; i < NUM_REQUESTS; i++) {
            executor.submit(NotebookApiLoadTester::sendGetRequest);
        }
        executor.shutdown();
        boolean b = executor.awaitTermination(10, TimeUnit.MINUTES);
        if (!b)
            System.out.println("Some tasks did not finish within the timeout.");
        else
            System.out.println("All requests completed.");
    }

    private static void sendGetRequest() {
        long startTime = System.currentTimeMillis();
        try {
            URL url = new URL(API_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            int responseCode = conn.getResponseCode();
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuilder response = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();
            long endTime = System.currentTimeMillis();
            System.out.println("Response Code: " + responseCode + ", Time: " + (endTime - startTime) + "ms");
        } catch (Exception e) {
            long endTime = System.currentTimeMillis();
            System.out.println("Request failed after " + (endTime - startTime) + "ms: " + e.getMessage());
        }
    }
}


