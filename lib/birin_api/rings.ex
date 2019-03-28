defmodule BirinApi.Rings do
  @moduledoc """
  The Rings context.
  """

  import Ecto.Query, warn: false
  alias BirinApi.Repo

  alias BirinApi.Rings.RingNumber

  @doc """
  Returns the list of ring_number.

  ## Examples

      iex> list_ring_number()
      [%RingNumber{}, ...]

  """
  def list_ring_number do
    Repo.all(RingNumber)
  end

  @doc """
  Gets a single ring_number.

  Raises `Ecto.NoResultsError` if the Ring number does not exist.

  ## Examples

      iex> get_ring_number!(123)
      %RingNumber{}

      iex> get_ring_number!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ring_number!(id), do: Repo.get!(RingNumber, id)

  @doc """
  Creates a ring_number.

  ## Examples

      iex> create_ring_number(%{field: value})
      {:ok, %RingNumber{}}

      iex> create_ring_number(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ring_number(attrs \\ %{}) do
    %RingNumber{}
    |> RingNumber.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ring_number.

  ## Examples

      iex> update_ring_number(ring_number, %{field: new_value})
      {:ok, %RingNumber{}}

      iex> update_ring_number(ring_number, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ring_number(%RingNumber{} = ring_number, attrs) do
    ring_number
    |> RingNumber.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a RingNumber.

  ## Examples

      iex> delete_ring_number(ring_number)
      {:ok, %RingNumber{}}

      iex> delete_ring_number(ring_number)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ring_number(%RingNumber{} = ring_number) do
    Repo.delete(ring_number)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ring_number changes.

  ## Examples

      iex> change_ring_number(ring_number)
      %Ecto.Changeset{source: %RingNumber{}}

  """
  def change_ring_number(%RingNumber{} = ring_number) do
    RingNumber.changeset(ring_number, %{})
  end
end
