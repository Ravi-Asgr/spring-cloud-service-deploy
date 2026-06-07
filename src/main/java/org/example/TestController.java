package org.example;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

  @GetMapping("/test")
  public ResponseEntity<String> test() {
	System.out.println("== /test invoked ==");  
    return ResponseEntity.ok("railway-test OK");
  }
}
