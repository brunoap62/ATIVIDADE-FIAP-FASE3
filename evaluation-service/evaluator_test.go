package main

import (
	"testing"
)

func TestDeterministicBucket(t *testing.T) {
	bucket1 := getDeterministicBucket("user123_new_feature")
	bucket2 := getDeterministicBucket("user123_new_feature")

	if bucket1 != bucket2 {
		t.Fatalf("Esperado balde determinístico idêntico, obteve %d e %d", bucket1, bucket2)
	}

	if bucket1 < 0 || bucket1 >= 100 {
		t.Fatalf("Balde deve estar entre 0 e 99, obteve %d", bucket1)
	}
}

func TestRunEvaluationLogic(t *testing.T) {
	app := &App{}

	// Flag desabilitada -> deve retornar false
	disabledFlag := &CombinedFlagInfo{
		Flag: &Flag{
			Name:      "test_flag",
			IsEnabled: false,
		},
	}
	if app.runEvaluationLogic(disabledFlag, "user1") != false {
		t.Errorf("Esperado false para flag desabilitada")
	}

	// Flag habilitada sem regra -> deve retornar true
	enabledFlagNoRule := &CombinedFlagInfo{
		Flag: &Flag{
			Name:      "test_flag",
			IsEnabled: true,
		},
	}
	if app.runEvaluationLogic(enabledFlagNoRule, "user1") != true {
		t.Errorf("Esperado true para flag habilitada sem regra")
	}

	// Flag habilitada com regra 100% -> deve retornar true
	flag100Percent := &CombinedFlagInfo{
		Flag: &Flag{
			Name:      "test_flag",
			IsEnabled: true,
		},
		Rule: &TargetingRule{
			IsEnabled: true,
			Rules: Rule{
				Type:  "PERCENTAGE",
				Value: float64(100),
			},
		},
	}
	if app.runEvaluationLogic(flag100Percent, "user1") != true {
		t.Errorf("Esperado true para regra de 100%%")
	}

	// Flag habilitada com regra 0% -> deve retornar false
	flag0Percent := &CombinedFlagInfo{
		Flag: &Flag{
			Name:      "test_flag",
			IsEnabled: true,
		},
		Rule: &TargetingRule{
			IsEnabled: true,
			Rules: Rule{
				Type:  "PERCENTAGE",
				Value: float64(0),
			},
		},
	}
	if app.runEvaluationLogic(flag0Percent, "user1") != false {
		t.Errorf("Esperado false para regra de 0%%")
	}
}
