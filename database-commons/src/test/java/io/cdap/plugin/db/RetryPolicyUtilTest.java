/*
 * Copyright © 2019 Cask Data, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */

package io.cdap.plugin.db;

import dev.failsafe.Failsafe;
import dev.failsafe.FailsafeException;
import dev.failsafe.RetryPolicy;
import io.cdap.plugin.db.connector.AbstractDBConnectorConfig;
import io.cdap.plugin.util.RetryPolicyUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.SQLSyntaxErrorException;
import java.sql.SQLTransientConnectionException;
import java.util.concurrent.atomic.AtomicInteger;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class RetryPolicyUtilTest {

    private AbstractDBConnectorConfig mockConfig;

    @BeforeEach
    public void setup() {
        mockConfig = mock(AbstractDBConnectorConfig.class);
        when(mockConfig.getInitialRetryDuration()).thenReturn(5);
        when(mockConfig.getMaxRetryDuration()).thenReturn(10);
        when(mockConfig.getMaxRetryCount()).thenReturn(2);
    }

    @Test
    public void testCreateConnectionRetryPolicy_Retryable() {
        RetryPolicy<Object> retryPolicy = RetryPolicyUtil
          .createConnectionRetryPolicy(mockConfig.getInitialRetryDuration(), mockConfig.getMaxRetryDuration(),
            mockConfig.getMaxRetryCount());

        AtomicInteger attemptCounter = new AtomicInteger();

      FailsafeException ex = assertThrows(FailsafeException.class, () -> Failsafe.with(retryPolicy).run(() -> {
        attemptCounter.incrementAndGet();
        throw new SQLTransientConnectionException("Temporary issue");
      }));

      assertTrue(ex.getCause() instanceof SQLTransientConnectionException);
      assertEquals(3, attemptCounter.get(), "Expected 2 retries + 1 initial attempt");
    }

    @Test
    public void testCreateConnectionRetryPolicy_NonRetryable() {
      RetryPolicy<Object> retryPolicy = RetryPolicyUtil
        .createConnectionRetryPolicy(mockConfig.getInitialRetryDuration(), mockConfig.getMaxRetryDuration(),
                                     mockConfig.getMaxRetryCount());

      AtomicInteger attemptCounter = new AtomicInteger();

      FailsafeException ex = assertThrows(FailsafeException.class, () ->
                Failsafe.with(retryPolicy).run(() -> {
                    attemptCounter.incrementAndGet();
                    throw new SQLSyntaxErrorException("Bad SQL syntax");
                }));
      assertTrue(ex.getCause() instanceof SQLSyntaxErrorException);
      assertEquals(1, attemptCounter.get(), "Should not retry for non-retryable exception");
    }
}

