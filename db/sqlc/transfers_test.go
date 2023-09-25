package db

import (
	"context"
	"course-youtube/util"
	"testing"

	"github.com/stretchr/testify/require"
)

func CreateRandomTransfer(t *testing.T) Transfer {
	sender := CreateRandomAccount(t)
	receiver := CreateRandomAccount(t)
	arg := CreateTransferParams{
		FromAccountID: sender.ID,
		ToAccountID:   receiver.ID,
		Amount:        util.RandomInt(0, sender.Balance),
	}
	transfer, err := testQueries.CreateTransfer(context.Background(), arg)
	require.NoError(t, err)
	require.NotEmpty(t, transfer)
	require.Equal(t, arg.FromAccountID, transfer.FromAccountID)
	require.Equal(t, arg.ToAccountID, transfer.ToAccountID)
	require.Equal(t, arg.Amount, transfer.Amount)
	require.NotZero(t, transfer.ID)
	require.NotZero(t, transfer.CreatedAt)
	return transfer
}

// func TestCreateTransfer(t *testing.T) {
// 	CreateRandomTransfer(t)
// }
//
// func TestGetTransfer() {
//
// }
